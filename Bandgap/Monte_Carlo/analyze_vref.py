#!/usr/bin/env python3
"""Analyze Monte Carlo Vref results from a CSV file."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

import numpy as np
import matplotlib.pyplot as plt


def read_vref(path: Path) -> np.ndarray:
    """Read the vref column from a CSV file."""
    data = np.genfromtxt(path, delimiter=",", names=True, dtype=None, encoding="utf-8")
    if data.dtype.names is None or "vref" not in data.dtype.names:
        raise ValueError(f"CSV must contain a 'vref' column: {path}")

    values = np.atleast_1d(data["vref"]).astype(float)

    if values.size == 0:
        raise ValueError(f"No vref data found: {path}")
    return values


def read_tt_vref(path: Path, target_temperature: float) -> float:
    """Read v(vref) nearest to target_temperature from a binary ngspice raw file."""
    raw = path.read_bytes()
    binary_marker = b"Binary:\n"
    binary_offset = raw.find(binary_marker)
    if binary_offset < 0:
        raise ValueError(f"Expected a binary ngspice raw file: {path}")

    header = raw[:binary_offset].decode("ascii", errors="replace")
    variables_match = re.search(
        r"Variables:\n(?P<variables>.*)$", header, re.MULTILINE | re.DOTALL
    )
    if variables_match is None:
        raise ValueError(f"Could not find Variables section in raw file: {path}")

    variable_names = {}
    for line in variables_match.group("variables").splitlines():
        match = re.match(r"\s*(\d+)\s+([^\s]+)", line)
        if match:
            variable_names[match.group(2).lower()] = int(match.group(1))

    temperature_index = next(
        (variable_names[name] for name in ("temp-sweep", "temperature", "temp") if name in variable_names),
        None,
    )
    vref_index = next(
        (variable_names[name] for name in ("v(vref)", "vref") if name in variable_names),
        None,
    )
    points_match = re.search(r"No\. Points:\s*(\d+)", header)
    if temperature_index is None or vref_index is None or points_match is None:
        raise ValueError(f"Could not identify temperature, vref, or point count in: {path}")

    point_count = int(points_match.group(1))
    variable_count = len(variable_names)
    values = np.frombuffer(
        raw,
        dtype="<f8",
        offset=binary_offset + len(binary_marker),
        count=point_count * variable_count,
    ).reshape(point_count, variable_count)
    temperatures = values[:, temperature_index]
    row = int(np.argmin(np.abs(temperatures - target_temperature)))
    return float(values[row, vref_index])


def plot_results(
    csv_file: Path,
    values: np.ndarray,
    nominal: float,
    mean: float,
    median: float,
    output: Path,
) -> None:
    """Save a histogram and run-by-run plot of the Monte Carlo results."""
    runs = np.arange(values.size)
    figure, axes = plt.subplots(2, 1, figsize=(10, 8), constrained_layout=True)

    axes[0].hist(values, bins="auto", color="steelblue", edgecolor="white")
    axes[0].axvline(nominal, color="crimson", linestyle="--", label=f"Nominal: {nominal:.6f} V")
    axes[0].axvline(mean, color="darkgreen", linestyle="-", label=f"Mean: {mean:.6f} V")
    axes[0].axvline(median, color="darkorange", linestyle=":", label=f"Median: {median:.6f} V")
    axes[0].set_title("Monte Carlo Vref distribution")
    axes[0].set_xlabel("Vref (V)")
    axes[0].set_ylabel("Number of runs")
    axes[0].legend()
    axes[0].grid(alpha=0.25)

    axes[1].plot(runs, values, ".", markersize=3, color="steelblue")
    axes[1].axhline(nominal, color="crimson", linestyle="--", label="Nominal")
    axes[1].axhline(mean, color="darkgreen", linestyle="-", label="Mean")
    axes[1].axhline(median, color="darkorange", linestyle=":", label="Median")
    axes[1].set_title("Vref for each Monte Carlo run")
    axes[1].set_xlabel("Run")
    axes[1].set_ylabel("Vref (V)")
    axes[1].legend()
    axes[1].grid(alpha=0.25)

    figure.suptitle(f"Monte Carlo analysis: {csv_file.name}")
    figure.savefig(output, dpi=150)
    plt.close(figure)


def format_report(
    csv_file: Path,
    values: np.ndarray,
    nominal: float,
    mean: float,
    median: float,
    sigma: float,
) -> str:
    """Format the statistical report."""
    sigma_percent = sigma / nominal * 100 if nominal else float("nan")
    return "\n".join(
        [
            f"File           : {csv_file}",
            f"Number of runs : {values.size}",
            f"Nominal        : {nominal:.6f} V",
            f"Mean           : {mean:.6f} V",
            f"Median         : {median:.6f} V",
            f"Sample sigma   : {sigma:.6f} V ({sigma_percent:.3f} % of nominal)",
            f"3-sigma range  : {nominal - 3 * sigma:.6f} .. {nominal + 3 * sigma:.6f} V",
            f"Min / max      : {np.min(values):.6f} .. {np.max(values):.6f} V",
        ]
    )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "csv_file",
        nargs="?",
        type=Path,
        default=Path(__file__).with_name("vref_27.csv"),
        help="CSV file with a vref column (default: vref_27.csv)",
    )
    parser.add_argument(
        "--nominal",
        type=float,
        help="User-defined nominal value; overrides the TT raw value",
    )
    parser.add_argument(
        "--tt-raw",
        type=Path,
        default=Path(__file__).parents[1] / "Result" / "tt.raw",
        help="TT temperature-sweep raw file (default: ../Result/tt.raw)",
    )
    parser.add_argument(
        "--tt-temp",
        type=float,
        default=27.0,
        help="Temperature in C used for the TT nominal (default: 27)",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(__file__).parents[1] / "Schem_Res" / "vref_statistics.txt",
        help="Report output file (default: ../Schem_Res/vref_statistics.txt)",
    )
    parser.add_argument(
        "--plot",
        type=Path,
        default=Path(__file__).parents[1] / "Schem_Res" / "vref_results.png",
        help="Plot output file (default: ../Schem_Res/vref_results.png)",
    )
    args = parser.parse_args()

    values = read_vref(args.csv_file)
    mean = float(np.mean(values))
    median = float(np.median(values))
    sigma = float(np.std(values, ddof=1))
    if args.nominal is not None:
        nominal = args.nominal
    elif args.tt_raw.exists():
        nominal = read_tt_vref(args.tt_raw, args.tt_temp)
    else:
        nominal = mean
        print(f"Warning: {args.tt_raw} not found; using Monte Carlo mean as nominal")
    report = format_report(args.csv_file, values, nominal, mean, median, sigma)

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(report + "\n", encoding="utf-8")
    args.plot.parent.mkdir(parents=True, exist_ok=True)
    plot_results(args.csv_file, values, nominal, mean, median, args.plot)
    print(report)
    print(f"Report saved : {args.output}")
    print(f"Plot saved   : {args.plot}")


if __name__ == "__main__":
    main()
