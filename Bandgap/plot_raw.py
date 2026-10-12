#!/usr/bin/env python3
"""Plot voltage traces from ngspice binary raw files."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np


def read_ngspice_raw(path: Path) -> tuple[list[str], np.ndarray]:
    raw = path.read_bytes()
    marker = b"Binary:\n"
    data_start = raw.index(marker) + len(marker)
    header = raw[:data_start].decode("ascii")

    variables = [
        match.group(2)
        for match in re.finditer(r"^\s*(\d+)\s+(\S+)\s+\S+\s*$", header, re.MULTILINE)
    ]
    points_match = re.search(r"^No\. Points:\s*(\d+)", header, re.MULTILINE)
    if not variables or points_match is None:
        raise ValueError(f"Unsupported or incomplete ngspice raw header: {path}")

    point_count = int(points_match.group(1))
    values = np.frombuffer(raw, dtype="<f8", offset=data_start)
    expected_count = point_count * len(variables)
    if values.size < expected_count:
        raise ValueError(f"Raw data is truncated: {path}")

    return variables, values[:expected_count].reshape(point_count, len(variables))


def extract_corner_metrics(path: Path) -> dict[str, float | str]:
    variables, data = read_ngspice_raw(path)
    try:
        temperature_index = variables.index("temp-sweep")
        voltage_index = variables.index("v(vref)")
    except ValueError as error:
        raise ValueError(f"Expected temp-sweep and v(vref) in {path}") from error

    temperature = data[:, temperature_index]
    voltage = data[:, voltage_index]
    order = np.argsort(temperature)
    temperature = temperature[order]
    voltage = voltage[order]
    minimum_index = int(np.argmin(voltage))
    maximum_index = int(np.argmax(voltage))

    return {
        "corner": path.stem,
        "vref_27": float(np.interp(27.0, temperature, voltage)),
        "vref_min": float(voltage[minimum_index]),
        "vref_min_temp": float(temperature[minimum_index]),
        "vref_max": float(voltage[maximum_index]),
        "vref_max_temp": float(temperature[maximum_index]),
    }


def make_readme_table(metrics: list[dict[str, float | str]]) -> str:
    metrics = sorted(metrics, key=lambda item: ("tt", "ss", "ff").index(item["corner"]))
    tt_vref = next(item["vref_27"] for item in metrics if item["corner"] == "tt")
    rows = [
        "| Corner | Vref @ 27 °C | Vref min | Vref max | Peak-to-peak | TC (ppm/°C) | Shift vs. tt @ 27 °C |",
        "| ------ | ------------ | -------- | -------- | ------------ | ----------- | -------------------- |",
    ]
    for item in metrics:
        vref_27 = float(item["vref_27"])
        vref_min = float(item["vref_min"])
        vref_max = float(item["vref_max"])
        peak_to_peak = vref_max - vref_min
        tc = peak_to_peak / (vref_27 * 165.0) * 1e6
        if item["corner"] == "tt":
            shift = "n/a"
        else:
            shift_value = vref_27 - float(tt_vref)
            shift_percent = shift_value / float(tt_vref) * 100.0
            shift = f"≈ {shift_value * 1e3:+.0f} mV ({shift_percent:+.1f} %)"
        rows.append(
            f"| {item['corner']}     | ≈ {vref_27:.4f} V   | "
            f"≈ {vref_min:.4f} V ({float(item['vref_min_temp']):g} °C) | "
            f"≈ {vref_max:.4f} V ({float(item['vref_max_temp']):g} °C)  | "
            f"≈ {peak_to_peak * 1e3:.1f} mV | ≈ {tc:.0f} | {shift} |"
        )
    return "\n".join(rows)


def update_readme(path: Path, table: str) -> None:
    text = path.read_text()
    lines = text.splitlines()
    header_index = next(
        (index for index, line in enumerate(lines) if line.startswith("| Corner | Vref @ 27 °C |")),
        None,
    )
    if header_index is None or len(lines) < header_index + 5:
        raise ValueError(f"Could not find the corner-results table in {path}")
    replacement = table.splitlines()
    lines[header_index : header_index + 5] = replacement
    path.write_text("\n".join(lines) + "\n")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "files",
        nargs="*",
        type=Path,
        help="ngspice raw files; defaults to Bandgap/Result/{ff,ss,tt}.raw",
    )
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        default=Path("Bandgap/Schem_Res/bandgap_corners.png"),
    )
    parser.add_argument(
        "--update-readme",
        action="store_true",
        help="extract corner metrics and replace the matching table in readme.md",
    )
    parser.add_argument(
        "--readme",
        type=Path,
        default=Path("readme.md"),
        help="README path used with --update-readme",
    )
    args = parser.parse_args()
    files = args.files or [Path("Bandgap/Result") / f"{corner}.raw" for corner in ("ff", "ss", "tt")]
    metrics = [extract_corner_metrics(path) for path in files]

    figure, axis = plt.subplots(figsize=(8, 5))
    for path in files:
        variables, data = read_ngspice_raw(path)
        temperature_index = variables.index("temp-sweep")
        voltage_index = variables.index("v(vref)")
        axis.plot(data[:, temperature_index], data[:, voltage_index], label=path.stem)

    axis.set_xlabel("Temperature (degC)")
    axis.set_ylabel("Vref (V)")
    axis.grid(True, alpha=0.3)
    axis.legend(title="Corner")
    figure.tight_layout()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(args.output, dpi=160)
    print(f"Saved {args.output}")
    if args.update_readme:
        update_readme(args.readme, make_readme_table(metrics))
        print(f"Updated {args.readme}")


if __name__ == "__main__":
    main()