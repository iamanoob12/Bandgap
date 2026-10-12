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
    args = parser.parse_args()
    files = args.files or [Path("Bandgap/Result") / f"{corner}.raw" for corner in ("ff", "ss", "tt")]

    figure, axis = plt.subplots(figsize=(8, 5))
    for path in files:
        variables, data = read_ngspice_raw(path)
        try:
            temperature_index = variables.index("temp-sweep")
            voltage_index = variables.index("v(vref)")
        except ValueError as error:
            raise ValueError(f"Expected temp-sweep and v(vref) in {path}") from error
        axis.plot(data[:, temperature_index], data[:, voltage_index], label=path.stem)

    axis.set_xlabel("Temperature (degC)")
    axis.set_ylabel("Vref (V)")
    axis.grid(True, alpha=0.3)
    axis.legend(title="Corner")
    figure.tight_layout()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(args.output, dpi=160)
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()