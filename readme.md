# SKY130 Bandgap Reference

This repository contains the Xschem schematics, device-level investigations,
and simulation results for a low-voltage bandgap reference using the SKY130
process design kit.

The project follows an Xschem-first workflow. Xschem schematics are the
source of truth; ngspice is used as the simulator through the schematic
simulation setup and generated netlists.

## Project status

- Target supply: 1.8 V
- Process: SKY130A
- Schematic editor: Xschem
- Simulator: ngspice 47 or newer
- Main circuit: bandgap reference with a two-stage amplifier
- Current testing iteration: V3.1 on the existing `Testing-V3` branch

The circuit is experimental and has not yet been characterized for production
use. Loop stability, PSRR, and line regulation may still require additional
work.

## Requirements

Install the following tools and make the SKY130A PDK available locally:

- Xschem
- ngspice 47+
- SKY130A PDK
- Python 3 for optional result-processing scripts

Set `PDK_ROOT` to the directory containing the PDK checkout. The exact model
and symbol paths are defined by the Xschem and simulation configuration used
by the schematics.

```sh
export PDK_ROOT=/path/to/your/pdk
```

## Repository structure

```text
.
├── Bandgap/
│   ├── Bandgap.sch          # Main bandgap schematic
│   ├── ota.sch              # OTA schematic used by the bandgap
│   ├── ota.sym              # Local Xschem symbol for the OTA
│   ├── plot.py              # Process-corner plotting script
│   ├── Monte_Carlo/         # Monte Carlo inputs and analysis script
│   ├── Startup/             # Startup analysis script
│   ├── outf/                # SPICE netlists and raw simulation data
│   └── Data/                # Generated plots and text reports
├── Bjt/
│   ├── pnp.spice            # PNP device investigation
│   └── vbe.txt              # Recorded VBE data
├── Mos_Analysis/
│   ├── NmosVth/              # NMOS threshold-voltage analysis
│   ├── PmosId/               # PMOS operating-point analysis
│   └── PmosVth/              # PMOS threshold-voltage analysis
└── readme.md
```

## Xschem workflow

1. Open `Bandgap/Bandgap.sch` or `Bandgap/ota.sch` in Xschem.
2. Check the device models, supply values, transistor dimensions, and wiring
	before running a simulation.
3. Run the simulation from Xschem using the schematic's configured ngspice
	simulation command.
4. Inspect waveforms and operating points in the Xschem/ngspice plot window.
5. Save rendered schematics under `Bandgap/Data/Schematics/` and plots/reports
	under the matching `Bandgap/Data/` analysis directory.
6. Keep generated raw data and netlists under `Bandgap/outf/` rather than
	editing generated files as the primary circuit source.

The standalone files under `Bjt/` and `Mos_Analysis/` are supporting device
studies. They are useful for checking the temperature behavior and operating
regions used when sizing the main schematic.

## Main schematics

### Bandgap reference

`Bandgap/Bandgap.sch` contains the main bandgap reference and its configured
simulation plots.

![Bandgap schematic](Bandgap/Data/Schematics/Bandgap_schem.png)

### OTA

`Bandgap/ota.sch` contains the OTA used in the current bandgap design.

![OTA schematic](Bandgap/Data/Schematics/OTA_schem.png)

## Results

Rendered schematics, simulation plots, and reports are stored in
`Bandgap/Data/`. The corresponding netlists and raw simulation data are in
`Bandgap/outf/`.

## Bandgap design evolution

This project evolved through the following stages:

1. **[Old-Bandgap branch](https://github.com/iamanoob12/Bandgap/tree/Old-Bandgap)** -
   an initial compact ngspice experiment using an ideal voltage-controlled
   op-amp and ideal resistor network together with SKY130 PNPs and PFETs. It
   established the basic bandgap behavior, with a simulated output of
   approximately 1.20--1.25 V over temperature, but did not yet model a
   realistic amplifier or fully characterize the reference.
2. **[V1 branch](https://github.com/iamanoob12/Bandgap/tree/V1)** - the
   design was moved toward an Xschem-first implementation with the
   two-stage amplifier, SKY130 device models, and a generic poly (PO)
   resistor model. V1 is the NMOS-input OTA baseline used for the first
   non-ideal implementation.
3. **[V2 branch](https://github.com/iamanoob12/Bandgap/tree/V2)** - the
   improved implementation uses a real two-stage OTA in the feedback loop,
   SKY130 high-poly (`res_high_po`) resistors, process-corner temperature
   sweeps, and Monte Carlo analysis. The typical-corner result is
   approximately 1.161 V at 27 °C, with 4--6 ppm/°C temperature coefficient
   across the process corners.
4. **[V3 branch](https://github.com/iamanoob12/Bandgap/tree/V3)** - keeps the
   same bandgap topology and design concept as V2, while increasing the
   transistor sizes in the OTA and Vbias-generation circuitry. The larger
   devices are intended to reduce the OTA overdrive voltage ($V_{ov}$) and
   improve the available operating margin. Like V2, V3 uses SKY130
   high-poly (`res_high_po`) resistors. The current V3 typical-corner result
   is approximately 1.190 V at 27 °C, with 6--8 ppm/°C temperature
   coefficient across the process corners.

V3.1 is a testing iteration of V3, not a new design branch. It is being
tested on the existing `Testing-V3` branch and keeps the same core feedback
topology. It changes selected device multipliers and dimensions, adds a
multi-temperature startup transient test, exports the Vref and
startup-branch raw waveforms, and refreshes the process-corner and Monte
Carlo result set.

Simulation data in `Bandgap/outf/` may be regenerated when the schematic or
simulation setup changes. The Python analysis scripts read raw data from
`Bandgap/outf/` and write results to the matching `Bandgap/Data/` folder:

```sh
.venv/bin/python Bandgap/plot.py
.venv/bin/python Bandgap/Monte_Carlo/analyze_vref.py
.venv/bin/python Bandgap/Startup/plot_startup.py
```

The corner script writes to `Bandgap/Data/Process_Corners/`.
The Monte Carlo script writes to `Bandgap/Data/Monte_Carlo/`.
The startup script writes separate Vref and startup-branch plots plus a timing
report to `Bandgap/Data/Startup/`.

## Vref versus temperature and process corner

Setup: 1.8 V supply, −40 °C to 120 °C, and the OTA in the loop. The process
corners are:

- `tt`: typical process models, used for the nominal baseline.
- `ss`: slow NMOS and slow PMOS process models.
- `ff`: fast NMOS and fast PMOS process models.
- `tt_mm`: typical process models with mismatch enabled, used by the Monte
  Carlo runs.

The `tt`, `ss`, and `ff` corner sweeps characterize process and temperature
variation without the Monte Carlo mismatch run. The `tt_mm` model is a
separate typical-corner model selection for mismatch analysis; it is not an
additional process corner.

| Corner | Vref @ 27 °C | Vref min | Vref max | Peak-to-peak | TC (ppm/°C) | Shift vs. tt @ 27 °C |
| ------ | ------------ | -------- | -------- | ------------ | ----------- | -------------------- |
| tt     | ≈ 1.2023 V   | ≈ 1.2002 V (119.9 °C) | ≈ 1.2024 V (18 °C)  | ≈ 2.1 mV | ≈ 11 | n/a |
| ss     | ≈ 1.2008 V   | ≈ 1.1986 V (-40 °C) | ≈ 1.2008 V (26.6 °C)  | ≈ 2.2 mV | ≈ 11 | ≈ -1.5 mV (-0.12 %) |
| ff     | ≈ 1.2039 V   | ≈ 1.2014 V (119.9 °C) | ≈ 1.2041 V (9.4 °C)  | ≈ 2.8 mV | ≈ 14 | ≈ +1.6 mV (+0.13 %) |

Temperature coefficient uses the box method over the simulated −40 °C to
120 °C range: TC = (Vmax − Vmin) / (Vref(27 °C) · 160 °C) · 10⁶.

Notes:
- The current V3.1 TT result is ≈ 1.202 V.
- The temperature coefficient ranges from approximately 11 to 14 ppm/°C across
  the three process corners.
- The corner-to-corner spread at 27 °C (ss to ff ≈ 3.1 mV, ≈ 0.26 %) is
  smaller than the earlier V3 result.
- The current V3.1 design uses SKY130 `res_high_po` resistor models, so the
  corner spread includes the resistor model's corner behavior. This result
  The table does not include resistor mismatch; mismatch is evaluated separately
  by the Monte Carlo analysis.
- Values above are extracted from the raw data and can be regenerated with the plotting helper.

![Bandgap corners](Bandgap/Data/Process_Corners/bandgap_corners.png)

## Monte Carlo variation

### Setup

The Monte Carlo run uses the SKY130 `tt_mm` model from
`sky130.lib.spice`, with a 1.8 V supply and an operating temperature of
27 °C. The control block performs 1,000 operating-point runs, resetting the
circuit before each run and writing the resulting `Vref` value to
`Bandgap/Monte_Carlo/vref_27.csv`. The `tt_mm` selection keeps the process at
the typical corner while enabling mismatch variation for `res_high_po`,
`res_generic_po`, and MOS devices. BJT mismatch is not enabled in this
analysis.

The nominal value reported below is taken from the separate TT raw-data
result, not from the Monte Carlo mean:

| Metric | Result |
| ------ | ------ |
| Nominal | 1.202339 V |
| Mean | 1.202780 V |
| Median | 1.202195 V |
| Sample sigma | 0.030108 V (2.504 %) |
| 3-sigma range | 1.112015 V to 1.292664 V |
| Observed minimum / maximum | 1.107700 V to 1.300520 V |

The 3-sigma range is calculated as `nominal ± 3 × sample sigma`. The V3.1
spread is narrower than the V3 result, but the mismatch model and circuit
operating point should still be investigated separately from the
process-corner result.

The distribution and run-by-run results are plotted from
`Bandgap/Monte_Carlo/vref_27.csv` by
`Bandgap/Monte_Carlo/analyze_vref.py`:

![Monte Carlo Vref distribution and runs](Bandgap/Data/Monte_Carlo/vref_results.png)

The full generated report is available in
[`Bandgap/Data/Monte_Carlo/vref_statistics.txt`](Bandgap/Data/Monte_Carlo/vref_statistics.txt).

### V1, V2, V3, and V3.1 comparison

The same `tt_mm` Monte Carlo setup was also used to compare the four design
revisions:

| Revision | OTA input pair and sizing | Nominal Vref | Mean Vref | Median Vref | Sample sigma | Observed behavior |
| -------- | ------------------------- | ------------ | --------- | ----------- | ------------ | ----------------- |
| V1 | NMOS input pair; undersized for mismatch margin | 1.148697 V | 1.148697 V | 1.175685 V | n/a | Very wide, asymmetric spread with many failed low-output runs |
| V2 | PMOS input OTA with a larger PTAT mirror current; OTA still undersized | 1.160903 V | 1.159738 V | 1.163740 V | 0.117148 V (117.15 mV, 10.091%) | Centered distribution, but significant mismatch sensitivity remains |
| V3 | Larger OTA devices to further reduce $V_{ov}$ | 1.190056 V | 1.184496 V | 1.183755 V | 0.063974 V (63.974 mV, 5.376%) | Improved operating margin and mismatch behavior relative to V1 and V2 |
| V3.1 | Same core topology; updated Q2, resistors, and OTA loads | 1.202339 V | 1.202780 V | 1.202195 V | 0.030108 V (30.108 mV, 2.504%) | Testing iteration; narrower observed spread than V3 |

V1's poor Monte Carlo behavior is caused by the two-stage OTA's NMOS input
pair. When mismatch separates the input devices, the input operating point can
be driven too low, causing failed Monte Carlo runs whose bandgap output is
approximately 0.5 V at 27 °C rather than the intended regulated value.

V2 replaces the NMOS-input OTA with a PMOS-input OTA and increases the PTAT
mirror current. This avoids the dominant V1 input-pair mismatch problem:
the PMOS and NMOS threshold voltages have different temperature behavior, and
the PMOS threshold magnitude decreases much more strongly with temperature
than the NMOS threshold voltage. However, the OTA sizing is still
insufficient: without mismatch, its initial overdrive voltage is only about
1--3 mV, leaving little margin for device variation.

V3 increases the OTA device sizes to further reduce the initial overdrive
voltage and improve the available operating margin. This is the sizing change
described in the V3 design rationale above; it is intended to make the loop
less sensitive to mismatch rather than change the bandgap topology.

![V1 Monte Carlo comparison](Bandgap/Data/Monte_Carlo/Revision_Comparisons/V1_monte_carlo.png)

![V2 Monte Carlo comparison](Bandgap/Data/Monte_Carlo/Revision_Comparisons/V2_monte_carlo.png)

## V3.1 testing iteration on `Testing-V3`

V3.1 is not a new Git branch. It is the current testing process on the
existing `Testing-V3` branch. The core bandgap feedback topology is retained,
but the implementation changes the following V3 devices and values:

| Element | V3 baseline | V3.1 testing |
| ------- | ----------- | ------------ |
| PTAT PNP `Q2` multiplier | `m=2` | `m=1` |
| `R1` length | 3.30 | 8.60 |
| `R2` length | 49.04 | 72.4 |
| OTA NMOS loads `M4`, `M5` | `W=4`, `L=0.50` | `W=10`, `L=1` |
| Startup devices | Not present | `M14/M17: W=15, L=0.18`; `M16: W=1, L=5` |

The PNP ratio therefore changes from the V3 8:2 implementation to 8:1 in
V3.1, while the feedback-based bandgap topology remains the same. V3.1 also
adds a startup transient test using a 10 µs control transition, 1 ns maximum
timestep, and simulations at -40 °C, 27 °C, and 120 °C. The generated raw files are stored under
`Bandgap/outf/Startup/`, with plots and reports under `Bandgap/Data/Startup/`.

| Measurement | V3 baseline | V3.1 testing result |
| ----------- | ----------- | ------------------- |
| TT Vref at 27 °C | ≈ 1.1901 V | ≈ 1.2023 V |
| TT temperature coefficient | ≈ 7 ppm/°C | ≈ 11 ppm/°C |
| Monte Carlo mean | 1.184496 V | 1.202780 V |
| Monte Carlo sample sigma | 63.974 mV (5.376%) | 30.108 mV (2.504%) |
| Startup time at -40 °C | Not measured | 2.853 µs |
| Startup time at 27 °C | Not measured | 110.629 ns |
| Startup time at 120 °C | Not measured | 1.761 ns |

Startup time is measured from the falling edge of `n1` until Vref reaches
90% of its final value. The `net3` waveform is a separate branch-off check;
its final values are 1.779540 V, 1.784151 V, and 1.787918 V at -40 °C, 27 °C,
and 120 °C respectively, which is close to the 1.8 V supply.

The current V3.1 evidence is collected in
`Bandgap/Data/Process_Corners/`, `Bandgap/Data/Monte_Carlo/`, and
`Bandgap/Data/Startup/`. These results are still testing data and should not
be treated as a finalized characterization release.

## Startup

The startup test uses a switched PMOS startup path. `VSTART` drives the
control node from 1.8 V to 0 V at 10 µs, turning the startup path off through
`SSTART`. Each transient run uses a 1 ns maximum timestep and runs from 10 µs
to 17 µs at -40 °C, 27 °C, and 120 °C.

Startup time is measured from the falling edge of `n1` until Vref reaches 90%
of its final value. The startup branch itself is checked separately using
`net3`; its final voltage should approach the 1.8 V supply after startup.

| Temperature | Vref final | 90% Vref | n1 fall | Vref reaches 90% | Startup time | net3 final |
| ----------- | ---------- | -------- | ------- | ----------------- | ------------ | ---------- |
| -40 °C | 1.199903 V | 1.079912 V | 10.000533 µs | 12.853257 µs | 2.853 µs | 1.779540 V |
| 27 °C | 1.202338 V | 1.082104 V | 10.000521 µs | 10.111150 µs | 110.629 ns | 1.784151 V |
| 120 °C | 1.200234 V | 1.080211 V | 10.000521 µs | 10.002283 µs | 1.761 ns | 1.787918 V |

The Vref startup waveforms are shown below:

![V3.1 Vref startup](Bandgap/Data/Startup/startup_vref.png)

The `net3` waveform verifies that the startup branch turns off toward VDD:

![V3.1 startup branch](Bandgap/Data/Startup/startup_voltage.png)

## Topology evolution

The first design attempt used a diode-connected PMOS and diode-connected NMOS
stacked directly in series with the PNP sensing device (the classic Brokaw-style
PTAT stack). Checking the minimum voltage this stack requires, using
SKY130's threshold voltages at 27 °C — $|V_{thp}|=0.95V$, $V_{thn}=0.7V$,
and $V_{BE}\approx0.7V$ — gives:

$$V_{DD} \geq |V_{thp}| + V_{thn} + V_{BE} = 0.95 + 0.7 + 0.7 = 2.35V$$

This exceeds the 1.8 V supply even at zero overdrive voltage on both
transistors, before any margin is added for saturation or process/temperature
variation. Since diode-connected devices force $V_{GS}=V_{th}+V_{ov}$ with no
freedom to reduce $V_{ov}$ below zero, no amount of device sizing can close
this gap — the stacked diode-connected topology is structurally infeasible at
1.8 V in this process, and a different topology was required.

The design was reworked to remove the diode-connected NMOS from the PTAT
branch entirely. A single PMOS current source per branch, with an op-amp
forcing the two branch drain voltages to match, replaces the second
diode-connected device and its associated headroom cost. This keeps the
series-stacked device count in each sensing branch to one PMOS plus one BJT,
which fits inside the 1.8 V supply with real margin.

## Earlier V1 PMOS sizing analysis

Device sizing was checked at the worst case for threshold-voltage headroom:
the `tt` corner at -40 °C, where $|V_{thp}|$ rises to approximately 1.03 V.
Using $\Delta V_{BE}=\frac{kT}{q}\ln(8)$ (an 8:1 PNP emitter-area ratio) with
the earlier $R_1=1k\Omega$ value, the PTAT branch current at -40 °C works out
to approximately 40–50 µA. This is a V1 sizing reference; V2 uses
$R_1=500\ \Omega$ as described below.

At $W=1, L=0.5$ and biased for this worst-case current, the PMOS carries
$6.394588\times10^{-5}A$ at the edge of the saturation region — i.e., at
-40 °C the PMOS sits right at the triode/saturation boundary rather than
comfortably inside saturation. As temperature rises, $|V_{thp}|$ decreases,
increasing the available overdrive and moving the device further into
saturation, so -40 °C is the binding constraint for this sizing.

## V2 and V3 topology and sizing rationale

The V2 and V3 designs are revisions of the V1 topology described above. Both use an 8:2 PNP emitter-area ratio in the PTAT core, implemented with PNP
multipliers of $m=8$ and $m=2$. This PTAT structure uses the area-ratio
difference in $V_{BE}$ to generate
$\Delta V_{BE}=\frac{kT}{q}\ln(8/2)=\frac{kT}{q}\ln(4)$, which is converted
to a PTAT current through $R_1$. The 8:2 ratio, rather than the earlier 8:1
ratio, provides the required PTAT contribution while allowing the PMOS
current mirror to operate in saturation.

The V2 and V3 designs use $R_1=500\ \Omega$, half the value used in the
Old-Bandgap design. This lower resistance is intentional. It increases the
PTAT current produced by the $\Delta V_{BE}$ term and allows the PMOS load
above the PNP devices to operate closer to the weak-inversion/strong-inversion
transition, rather than being limited by the low-current operating point of
the earlier design. The PMOS operating region and its margin should still be
checked across process, temperature, and supply corners.

The CTAT branch is different from the PTAT core: it uses a single PNP rather
than the 8:2 PNP pair. Its temperature dependence is therefore obtained from
the $dV_{BE}/dT$ extracted from the BJT SPICE run, approximately
$-1.25$ to $-1.4\ \mathrm{mV}/^\circ\mathrm{C}$ over the observed range.
The OTA combines this single-PNP CTAT voltage with the PTAT contribution to
set the Vref temperature coefficient.

In V2, the PMOS devices were resized substantially larger and $R_1$ (also
referred to as $R_{BE}$ in the earlier design discussion) was reduced. These
changes increase the current in each branch and provide the drive required by
the larger PMOS devices. V3 keeps the same topology, PNP area scaling, and
resistor value, but increases the device sizes in the OTA and Vbias-generation
circuits. This sizing change targets a lower OTA $V_{ov}$; it does not change
the underlying V2/V3 bandgap concept or feedback relationship.

## Future work

- Analyze PSRR.
- Check loop stability, compensation, and line regulation.

Startup testing is complete for the current V3.1 iteration. Load regulation
is not a target for this bandgap reference; load regulation belongs to a
separate LDO or load-driving stage that uses the bandgap as a reference.
