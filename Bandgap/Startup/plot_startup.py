#!/usr/bin/env python3
"""Plot startup and Vref waveforms from ngspice binary raw files."""

from __future__ import annotations

import argparse
import re
from dataclasses import dataclass
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np


STARTUP_DIR = Path(__file__).resolve().parent
BANDGAP_DIR = STARTUP_DIR.parent
RAW_DIR = BANDGAP_DIR / "outf" / "Startup"
RESULT_DIR = BANDGAP_DIR / "Data" / "Startup"
TEMPERATURES = (-40, 27, 120)


@dataclass(frozen=True)
class Dataset:
    """One appended transient dataset from an ngspice raw file."""

    variables: tuple[str, ...]
    data: np.ndarray

    def column(self, name: str) -> np.ndarray:
        """Return a named waveform column."""
        try:
            return self.data[:, self.variables.index(name)]
        except ValueError as error:
            raise ValueError(f"{name!r} is not present in the raw dataset") from error

    def waveform(self, fragment: str) -> np.ndarray:
        """Return the first waveform whose name contains a fragment."""
        try:
            name = next(name for name in self.variables if fragment in name)
        except StopIteration as error:
            raise ValueError(f"No waveform containing {fragment!r} is present") from error
        return self.column(name)


def read_ngspice_raw(path: Path) -> list[Dataset]:
    """Read all appended binary datasets in an ngspice raw file."""
    raw = path.read_bytes()
    markers = list(re.finditer(b"Binary:\n", raw))
    if not markers:
        raise ValueError(f"Expected binary ngspice data in {path}")

    datasets: list[Dataset] = []
    for marker_index, marker in enumerate(markers):
        header_start = raw.rfind(b"Title:", 0, marker.start())
        if header_start < 0:
            raise ValueError(f"Could not find dataset header in {path}")
        header = raw[header_start : marker.end()].decode("ascii")
        variable_count_match = re.search(
            r"^No\. Variables:\s*(\d+)", header, re.MULTILINE
        )
        point_count_match = re.search(
            r"^No\. Points:\s*(\d+)", header, re.MULTILINE
        )
        variable_matches = re.findall(
            r"^\s*\d+\s+(\S+)\s+\S+\s*$", header, re.MULTILINE
        )
        if variable_count_match is None or point_count_match is None:
            raise ValueError(f"Incomplete ngspice raw header in {path}")

        variable_count = int(variable_count_match.group(1))
        point_count = int(point_count_match.group(1))
        variables = tuple(variable_matches[-variable_count:])
        if len(variables) != variable_count:
            raise ValueError(f"Could not parse variables in {path}")

        data_start = marker.end()
        next_marker = (
            markers[marker_index + 1].start()
            if marker_index + 1 < len(markers)
            else len(raw)
        )
        values = np.frombuffer(
            raw, dtype="<f8", offset=data_start, count=point_count * variable_count
        )
        if values.size != point_count * variable_count:
            raise ValueError(f"Raw data is truncated in {path}")
        datasets.append(Dataset(variables, values.reshape(point_count, variable_count)))

        if data_start + values.nbytes > next_marker:
            raise ValueError(f"Dataset data overlaps the next header in {path}")

    return datasets


def measure_startup_time(
    n1_dataset: Dataset, vref_dataset: Dataset
) -> tuple[float, float, float, float]:
    """Measure n1 fall to Vref reaching 90% of its final value."""
    time = n1_dataset.column("time")
    n1 = n1_dataset.waveform("n1")
    vref_time = vref_dataset.column("time")
    vref = vref_dataset.waveform("vref")

    fall_index = int(np.argmin(np.gradient(n1, time)))
    fall_time = float(time[fall_index])
    final_vref = float(vref[-1])
    target = 0.9 * final_vref
    after_fall = np.flatnonzero((vref_time >= fall_time) & (vref >= target))
    if after_fall.size == 0:
        raise ValueError("Vref did not reach 90% of its final value after n1 fell")
    startup_time = float(vref_time[after_fall[0]])
    return fall_time, startup_time, startup_time - fall_time, target


def plot_vref(datasets: list[Dataset], output: Path) -> None:
    """Plot Vref for all available temperatures."""
    figure, axis = plt.subplots(figsize=(8, 5))
    for temperature, dataset in zip(TEMPERATURES, datasets):
        axis.plot(
            dataset.column("time") * 1e6,
            dataset.waveform("vref"),
            label=f"{temperature} °C",
        )
    axis.set_xlabel("Time (µs)")
    axis.set_ylabel("Vref (V)")
    axis.set_title("Bandgap reference startup")
    axis.grid(True, alpha=0.3)
    axis.legend(title="Temperature")
    figure.tight_layout()
    output.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(output, dpi=160)
    plt.close(figure)


def plot_startup_voltage(datasets: list[Dataset], output: Path) -> None:
    """Plot net3 to verify that the startup branch turns off toward Vdd."""
    figure, axis = plt.subplots(figsize=(8, 5))
    for temperature, dataset in zip(TEMPERATURES, datasets):
        time = dataset.column("time") * 1e6
        startup_name = next(name for name in dataset.variables if "net3" in name)
        axis.plot(time, dataset.column(startup_name), label=f"net3, {temperature} °C")

    axis.set_xlabel("Time (µs)")
    axis.set_ylabel("Voltage (V)")
    axis.set_title("Startup branch turn-off (net3 approaches Vdd)")
    axis.grid(True, alpha=0.3)
    axis.legend()
    figure.tight_layout()
    output.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(output, dpi=160)
    plt.close(figure)


def write_startup_report(
    vref_datasets: list[Dataset], branch_datasets: list[Dataset], output: Path
) -> None:
    """Write measured n1-fall-to-Vref-startup times and net3 final voltage."""
    lines = [
        "Startup time measured from the n1 falling edge to Vref reaching 90% of its final value",
        "The startup_branch net3 waveform is reported separately to verify that the branch turns off toward Vdd.",
        "Only datasets containing the saved n1 waveform are included.",
        "",
        "Temperature | n1 fall (us) | Vref final (V) | 90% Vref (V) | Vref reaches 90% (us) | startup time (ns) | net3 final (V)",
        "----------- | ------------- | -------------- | ------------ | ---------------------- | ----------------- | --------------",
    ]
    for temperature, (vref_dataset, branch_dataset) in zip(
        TEMPERATURES, zip(vref_datasets, branch_datasets)
    ):
        if not any("n1" in name for name in branch_dataset.variables):
            continue
        fall_time, startup_time, elapsed, target = measure_startup_time(
            branch_dataset, vref_dataset
        )
        final_vref = float(vref_dataset.waveform("vref")[-1])
        branch_name = next(name for name in branch_dataset.variables if "net3" in name)
        final_net3 = float(branch_dataset.column(branch_name)[-1])
        lines.append(
            f"{temperature:>11} | {fall_time * 1e6:>13.6f} | "
            f"{final_vref:>14.6f} | {target:>12.6f} | "
            f"{startup_time * 1e6:>22.6f} | {elapsed * 1e9:>17.3f} | "
            f"{final_net3:>14.6f}"
        )
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--vref-raw", type=Path, default=RAW_DIR / "startup.raw")
    parser.add_argument(
        "--startup-raw", type=Path, default=RAW_DIR / "startup_branch.raw"
    )
    parser.add_argument("--output-dir", type=Path, default=RESULT_DIR)
    args = parser.parse_args()

    vref_datasets = read_ngspice_raw(args.vref_raw)
    startup_datasets = read_ngspice_raw(args.startup_raw)
    if len(vref_datasets) != len(TEMPERATURES) or len(startup_datasets) != len(TEMPERATURES):
        raise ValueError("Expected one raw dataset for each configured temperature")

    plot_vref(vref_datasets, args.output_dir / "startup_vref.png")
    plot_startup_voltage(startup_datasets, args.output_dir / "startup_voltage.png")
    write_startup_report(
        vref_datasets, startup_datasets, args.output_dir / "startup_time.txt"
    )


if __name__ == "__main__":
    main()
