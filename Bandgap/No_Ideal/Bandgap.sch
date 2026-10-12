v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 510 80 510 120 {
lab=vdd}
N 730 80 730 120 {
lab=vdd}
N 510 80 730 80 {
lab=vdd}
N 550 150 690 150 {
lab=n1}
N 730 370 730 530 {
lab=n3}
N 510 370 510 530 {
lab=n2}
N 730 530 730 590 {
lab=n3}
N 510 590 510 610 {
lab=#net1}
N 730 590 730 610 {
lab=n3}
N 450 640 470 640 {
lab=0}
N 450 640 450 690 {
lab=0}
N 450 690 510 690 {
lab=0}
N 510 670 510 690 {
lab=0}
N 670 640 690 640 {
lab=0}
N 670 640 670 690 {
lab=0}
N 670 690 730 690 {
lab=0}
N 730 670 730 690 {
lab=0}
N 510 690 510 710 {
lab=0}
N 730 690 730 710 {
lab=0}
N 440 80 510 80 {
lab=vdd}
N 330 340 330 370 {
lab=0}
N 330 230 330 280 {
lab=vdd}
N 480 110 480 150 {
lab=vdd}
N 480 110 510 110 {
lab=vdd}
N 730 150 760 150 {
lab=vdd}
N 760 110 760 150 {
lab=vdd}
N 730 110 760 110 {
lab=vdd}
N 480 150 510 150 {lab=vdd}
N 510 350 510 370 {lab=n2}
N 510 180 510 290 {lab=n2}
N 730 180 730 260 {lab=n3}
N 510 340 510 350 {lab=n2}
N 730 340 730 370 {lab=n3}
N 730 260 730 340 {lab=n3}
N 510 290 510 340 {lab=n2}
N 620 150 620 170 {lab=n1}
N 440 400 530 400 {lab=0}
N 710 400 820 400 {lab=vdd}
N 440 400 440 430 {lab=0}
N 590 450 590 490 {lab=n2}
N 510 490 590 490 {lab=n2}
N 650 450 650 490 {lab=n3}
N 650 490 730 490 {lab=n3}
N 920 150 960 150 {lab=vdd}
N 960 90 960 150 {lab=vdd}
N 960 80 960 90 {lab=vdd}
N 730 80 960 80 {lab=vdd}
N 830 150 880 150 {lab=n1}
N 830 150 830 210 {lab=n1}
N 680 210 830 210 {lab=n1}
N 660 210 680 210 {lab=n1}
N 660 150 660 210 {lab=n1}
N 920 80 920 120 {lab=vdd}
N 920 180 920 360 {lab=vref}
N 920 590 920 610 {
lab=#net2}
N 860 640 880 640 {
lab=0}
N 860 640 860 690 {
lab=0}
N 860 690 920 690 {
lab=0}
N 920 670 920 690 {
lab=0}
N 920 690 920 710 {
lab=0}
N 920 420 920 590 {lab=#net2}
C {res.sym} 510 560 0 0 {name=R1
value=2k
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 440 80 0 0 {name=p1 sig_type=std_logic lab=vdd}
C {code_shown.sym} -510 140 0 0 {name=s1 only_toplevel=false 
value="
.control
  save all
  dc temp -40 125 1
  write tt.raw vref
.endc
"}
C {vsource.sym} 330 310 0 0 {name=V1 value=1.8 savecurrent=false}
C {lab_pin.sym} 330 230 0 0 {name=p2 sig_type=std_logic lab=vdd}
C {sky130_fd_pr/pfet_01v8.sym} 710 150 0 0 {name=M1
W=0.75
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 530 150 0 1 {name=M3
W=0.75
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pnp_05v5.sym} 490 640 0 0 {name=Q1
model=pnp_05v5_W3p40L3p40
m=8
spiceprefix=X
}
C {sky130_fd_pr/pnp_05v5.sym} 710 640 0 0 {name=Q2
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {lab_wire.sym} 620 150 0 0 {name=p3 sig_type=std_logic lab=n1}
C {lab_wire.sym} 510 370 0 0 {name=p4 sig_type=std_logic lab=n2}
C {lab_wire.sym} 730 370 0 0 {name=p5 sig_type=std_logic lab=n3}
C {two_stage.sym} 620 320 1 1 {name=x1}
C {lab_pin.sym} 820 400 0 1 {name=p6 sig_type=std_logic lab=vdd}
C {gnd.sym} 510 710 0 0 {name=l2 lab=0}
C {gnd.sym} 730 710 0 0 {name=l3 lab=0}
C {gnd.sym} 330 370 0 0 {name=l4 lab=0}
C {gnd.sym} 440 430 0 0 {name=l5 lab=0}
C {sky130_fd_pr/corner.sym} -510 350 0 0 {name=CORNER only_toplevel=true corner=ff}
C {sky130_fd_pr/pfet_01v8.sym} 900 150 0 0 {name=M2
W=0.75
L=0.15
nf=1
mult=10
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {res.sym} 920 390 0 0 {name=R2
value=1350
footprint=1206
device=resistor
m=1}
C {sky130_fd_pr/pnp_05v5.sym} 900 640 0 0 {name=Q3
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {gnd.sym} 920 710 0 0 {name=l1 lab=0}
C {lab_pin.sym} 920 290 0 1 {name=p7 sig_type=std_logic lab=vref}
