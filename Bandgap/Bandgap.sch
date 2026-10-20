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
N 730 180 730 420 {
lab=n3}
N 730 420 730 480 {
lab=n3}
N 510 480 510 500 {
lab=#net1}
N 730 480 730 500 {
lab=n3}
N 450 530 470 530 {
lab=GND}
N 450 530 450 580 {
lab=GND}
N 450 580 510 580 {
lab=GND}
N 510 560 510 580 {
lab=GND}
N 670 530 690 530 {
lab=GND}
N 670 530 670 580 {
lab=GND}
N 670 580 730 580 {
lab=GND}
N 730 560 730 580 {
lab=GND}
N 510 580 510 600 {
lab=GND}
N 730 580 730 600 {
lab=GND}
N 440 80 510 80 {
lab=vdd}
N 330 340 330 370 {
lab=GND}
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
N 510 460 510 480 {lab=#net1}
N 0 480 60 480 {lab=Vb}
N 400 430 400 460 {lab=n1}
N 360 460 400 460 {lab=n1}
N 100 160 300 160 {lab=vdd}
N 160 260 160 300 {lab=Vb}
N 90 230 120 230 {lab=Vb}
N 90 330 120 330 {lab=GND}
N 90 330 90 380 {lab=GND}
N 90 380 160 380 {lab=GND}
N 160 360 160 380 {lab=GND}
N 90 230 90 280 {lab=Vb}
N 90 280 160 280 {lab=Vb}
N 160 170 160 200 {lab=vdd}
N 160 280 210 280 {lab=Vb}
N 210 280 210 330 {lab=Vb}
N 160 330 210 330 {lab=Vb}
N 160 180 210 180 {lab=vdd}
N 210 180 210 230 {lab=vdd}
N 160 230 210 230 {lab=vdd}
N 160 160 160 170 {lab=vdd}
N 730 80 940 80 {lab=vdd}
N 940 80 940 120 {lab=vdd}
N 850 150 900 150 {lab=n1}
N 850 150 850 210 {lab=n1}
N 620 210 850 210 {lab=n1}
N 620 150 620 210 {lab=n1}
N 940 150 980 150 {lab=vdd}
N 980 110 980 150 {lab=vdd}
N 940 110 980 110 {lab=vdd}
N 940 380 940 500 {lab=#net2}
N 940 560 940 580 {lab=GND}
N 940 580 940 600 {lab=GND}
N 870 530 900 530 {lab=GND}
N 870 530 870 580 {lab=GND}
N 870 580 940 580 {lab=GND}
N 510 350 510 400 {lab=n2}
N 510 180 510 250 {lab=n2}
N 510 310 510 350 {lab=n2}
N 940 280 940 320 {lab=vref}
N 940 180 940 200 {lab=vref}
N 940 260 940 280 {lab=vref}
N 450 490 450 530 {lab=GND}
N 870 350 920 350 {lab=GND}
N 870 350 870 530 {lab=GND}
N 450 430 490 430 {lab=GND}
N 450 430 450 490 {lab=GND}
N 940 200 940 260 {lab=vref}
N 510 250 510 310 {lab=n2}
C {gnd.sym} 510 600 0 0 {name=l1 lab=GND}
C {gnd.sym} 730 600 0 0 {name=l2 lab=GND}
C {lab_pin.sym} 440 80 0 0 {name=p1 sig_type=std_logic lab=vdd}
C {code_shown.sym} -510 140 0 0 {name=s1 only_toplevel=false 
value="
.save all
.options savecurrent
.control 
  dc temp -40 120 0.1
  write "tt.raw" vref
  quit
.endc
"}
C {vsource.sym} 330 310 0 0 {name=V1 value=1.8 savecurrent=false}
C {gnd.sym} 330 370 0 0 {name=l4 lab=GND}
C {lab_pin.sym} 330 230 0 0 {name=p2 sig_type=std_logic lab=vdd}
C {sky130_fd_pr/pfet_01v8.sym} 710 150 0 0 {name=M1
W=10
L=0.50
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
W=10
L=0.50
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
C {sky130_fd_pr/pnp_05v5.sym} 490 530 0 0 {name=Q1
model=pnp_05v5_W3p40L3p40
m=8
spiceprefix=X
}
C {sky130_fd_pr/pnp_05v5.sym} 710 530 0 0 {name=Q2
model=pnp_05v5_W3p40L3p40
m=2
spiceprefix=X
}
C {sky130_fd_pr/corner.sym} -540 360 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/launcher.sym} -320 330 0 0 {name=h15
descr="Annotate OP" 
tclcommand="set show_hidden_texts 1; xschem annotate_op"
}
C {lab_wire.sym} 620 150 0 0 {name=p3 sig_type=std_logic lab=n1}
C {lab_wire.sym} 510 350 0 0 {name=p4 sig_type=std_logic lab=n2}
C {lab_wire.sym} 730 350 0 1 {name=p5 sig_type=std_logic lab=n3}
C {lab_pin.sym} 60 460 0 0 {name=p6 sig_type=std_logic lab=vdd}
C {lab_wire.sym} 60 500 0 0 {name=p7 sig_type=std_logic lab=n2}
C {lab_wire.sym} 60 520 0 0 {name=p8 sig_type=std_logic lab=n3}
C {gnd.sym} 60 540 0 0 {name=l3 lab=GND}
C {lab_wire.sym} 400 430 0 1 {name=p9 sig_type=std_logic lab=n1}
C {lab_wire.sym} 0 480 0 0 {name=p10 sig_type=std_logic lab=Vb}
C {lab_pin.sym} 100 160 0 0 {name=p11 sig_type=std_logic lab=vdd}
C {sky130_fd_pr/pfet_01v8.sym} 140 230 0 0 {name=M2
W=10
L=0.30
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
C {sky130_fd_pr/pfet_01v8.sym} 140 330 0 0 {name=M4
W=10
L=0.30
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
C {gnd.sym} 160 380 0 0 {name=l5 lab=GND}
C {lab_wire.sym} 90 230 0 0 {name=p12 sig_type=std_logic lab=Vb}
C {sky130_fd_pr/pfet_01v8.sym} 920 150 0 0 {name=M5
W=10
L=0.50
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
C {sky130_fd_pr/pnp_05v5.sym} 920 530 0 0 {name=Q3
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {gnd.sym} 940 600 0 0 {name=l6 lab=GND}
C {lab_wire.sym} 940 280 0 1 {name=p13 sig_type=std_logic lab=vref}
C {ota.sym} 210 500 0 0 {name=x1}
C {sky130_fd_pr/res_high_po.sym} 510 430 0 0 {name=R3
W=2.85
L=3.30
model=res_high_po
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po.sym} 940 350 0 0 {name=R1
W=2.85
L=48.41
model=res_high_po
spiceprefix=X
mult=1}
