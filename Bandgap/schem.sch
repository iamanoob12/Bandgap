v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 510 80 510 120 {
lab=Vdd}
N 730 80 730 120 {
lab=Vdd}
N 510 80 730 80 {
lab=Vdd}
N 550 150 690 150 {
lab=#net1}
N 730 180 730 330 {
lab=#net2}
N 510 180 510 330 {
lab=#net3}
N 510 300 590 300 {
lab=#net3}
N 650 300 730 300 {
lab=#net2}
N 620 150 620 180 {
lab=#net1}
N 730 330 730 390 {
lab=#net2}
N 510 390 510 410 {
lab=#net4}
N 730 390 730 410 {
lab=#net2}
N 450 440 470 440 {
lab=GND}
N 450 440 450 490 {
lab=GND}
N 450 490 510 490 {
lab=GND}
N 510 470 510 490 {
lab=GND}
N 670 440 690 440 {
lab=GND}
N 670 440 670 490 {
lab=GND}
N 670 490 730 490 {
lab=GND}
N 730 470 730 490 {
lab=GND}
N 510 490 510 510 {
lab=GND}
N 730 490 730 510 {
lab=GND}
N 440 80 510 80 {
lab=Vdd}
N 650 240 680 240 {
lab=GND}
N 680 240 680 260 {
lab=GND}
N 600 280 600 300 {
lab=#net3}
N 590 300 600 300 {
lab=#net3}
N 640 280 640 300 {
lab=#net2}
N 640 300 650 300 {
lab=#net2}
N 570 240 590 240 {
lab=#net1}
N 330 340 330 370 {
lab=GND}
N 330 230 330 280 {
lab=vdd}
N 480 150 510 150 {
lab=Vdd}
N 480 110 480 150 {
lab=Vdd}
N 480 110 510 110 {
lab=Vdd}
N 730 150 760 150 {
lab=Vdd}
N 760 110 760 150 {
lab=Vdd}
N 730 110 760 110 {
lab=Vdd}
N 570 200 570 240 {
lab=#net1}
N 570 200 620 200 {
lab=#net1}
N 620 180 620 200 {
lab=#net1}
N 620 180 620 200 {
lab=#net1}
N 620 200 850 200 {
lab=#net1}
N 850 150 850 200 {
lab=#net1}
N 850 150 940 150 {
lab=#net1}
N 730 80 980 80 {
lab=Vdd}
N 980 80 980 120 {
lab=Vdd}
N 980 150 1010 150 {
lab=Vdd}
N 1010 110 1010 150 {
lab=Vdd}
N 980 110 1010 110 {
lab=Vdd}
N 980 180 980 300 {
lab=vref}
N 980 360 980 410 {
lab=#net5}
N 980 470 980 490 {
lab=GND}
N 920 440 940 440 {
lab=GND}
N 920 440 920 490 {
lab=GND}
N 920 490 980 490 {
lab=GND}
N 980 490 980 510 {
lab=GND}
C {res.sym} 510 360 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {/home/goose/pdk/share/pdk/sky130A/libs.tech/xschem/sky130_fd_pr/pnp_05v5.sym} 490 440 0 0 {name=Q1
model=pnp_05v5_W3p40L3p40
m=8
spiceprefix=X
}
C {/home/goose/pdk/share/pdk/sky130A/libs.tech/xschem/sky130_fd_pr/pnp_05v5.sym} 710 440 0 0 {name=Q2
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {gnd.sym} 510 510 0 0 {name=l1 lab=GND}
C {gnd.sym} 730 510 0 0 {name=l2 lab=GND}
C {lab_pin.sym} 440 80 0 0 {name=p1 sig_type=std_logic lab=Vdd}
C {code_shown.sym} -510 140 0 0 {name=s1 only_toplevel=false 
value="
.lib "$PDK_ROOT/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
.save all

.dc temp -40 120 5
"}
C {vcvs.sym} 620 240 3 0 {name=E1 value=1Meg}
C {gnd.sym} 680 260 0 0 {name=l3 lab=GND}
C {vsource.sym} 330 310 0 0 {name=V1 value=1.8 savecurrent=false}
C {gnd.sym} 330 370 0 0 {name=l4 lab=GND}
C {lab_pin.sym} 330 230 0 0 {name=p2 sig_type=std_logic lab=vdd}
C {res.sym} 980 330 0 0 {name=R2
value=837
footprint=1206
device=resistor
m=1}
C {/home/goose/pdk/share/pdk/sky130A/libs.tech/xschem/sky130_fd_pr/pnp_05v5.sym} 960 440 0 0 {name=Q3
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {gnd.sym} 980 510 0 0 {name=l5 lab=GND}
C {lab_pin.sym} 980 260 0 0 {name=p3 sig_type=std_logic lab=vref}
C {/home/goose/open_pdks/sky130/sky130A/libs.tech/xschem/sky130_fd_pr/pfet_01v8.sym} 530 150 0 1 {name=M1
W=1
L=0.50
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'"
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'"
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'"
nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X}
C {/home/goose/open_pdks/sky130/sky130A/libs.tech/xschem/sky130_fd_pr/pfet_01v8.sym} 710 150 0 0 {name=M2
W=1
L=0.50
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'"
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'"
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'"
nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X}
C {/home/goose/open_pdks/sky130/sky130A/libs.tech/xschem/sky130_fd_pr/pfet_01v8.sym} 960 150 0 0 {name=M3
W=10
L=0.50
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'"
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'"
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'"
nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X}
