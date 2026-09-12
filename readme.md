
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

## PMOS sizing at the worst-case corner

Device sizing was checked at the worst case for threshold-voltage headroom:
the `tt` corner at -40 °C, where $|V_{thp}|$ rises to approximately 1.03 V.
Using $\Delta V_{BE}=\frac{kT}{q}\ln(8)$ (an 8:1 PNP emitter-area ratio) with
$R_1=1k\Omega$, the PTAT branch current at -40 °C works out to approximately
40–50 µA.

At $W=1, L=0.5$ and biased for this worst-case current, the PMOS carries
$6.394588\times10^{-5}A$ at the edge of the saturation region — i.e., at
-40 °C the PMOS sits right at the triode/saturation boundary rather than
comfortably inside saturation. As temperature rises, $|V_{thp}|$ decreases,
increasing the available overdrive and moving the device further into
saturation, so -40 °C is the binding constraint for this sizing.

## CTAT / Vref branch sizing

The CTAT (Vref-generating) branch reuses the same PTAT current through a
current mirror, but the mirrored branch was scaled to 10x the PTAT reference
current. This was done for two reasons: it reduces the required $R_2$ by the
same factor ($R_2\rightarrow R_2/10$ for the same voltage drop), keeping the
resistor value in a more practical range, and it reduces the relative impact
of $|V_{thp}|$ drift on the branch's operating point, since the larger bias
current keeps the mirror device further from the threshold-limited edge
identified above.

## Bandgap result

The simulated reference voltage is approximately 1.246 V near -25 °C and
decreases to approximately 1.197 V at 125 °C. The result is shown below:

![Simulated bandgap reference voltage versus temperature](https://github.com/iamanoob12/Bandgap/raw/main/Bandgap/res.png)

The bandgap netlist uses an ideal voltage-controlled op amp and SKY130 PFET
and PNP devices. It is intended as a compact circuit experiment rather than a
production-ready reference design; device sizing, loop stability, startup,
line regulation, and load behavior are not fully characterized.