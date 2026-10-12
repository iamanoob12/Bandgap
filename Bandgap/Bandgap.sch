v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 -300 50 500 450 {flags=graph,unlocked
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x2=125
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
autoload=1
sim_type=dc
color=4
node="\\"Bandgap tt; vref temp-sweep\\""
x1=-40
y1=1.177
rawfile=$netlist_dir/tt.raw
y2=1.18}
B 2 -300 450 500 850 {flags=graph,unlocked
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x2=125
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
node="\\"Bandgap ss; vref temp-sweep\\""
color=7
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/ss.raw
sim_type=dc
autoload=1
x1=-40
y1=1.19
y2=1.2}
B 2 -300 850 500 1250 {flags=graph,unlocked
y2=1.164
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
node="\\"Bandgap ff; vref temp-sweep\\""
color=6
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/ff.raw
sim_type=dc
x1=-40
x2=125
y1=1.16
autoload=1}
N 760 100 760 140 {
lab=vdd}
N 980 100 980 140 {
lab=vdd}
N 760 100 980 100 {
lab=vdd}
N 800 170 940 170 {
lab=n1}
N 980 390 980 550 {
lab=n3}
N 760 390 760 550 {
lab=n2}
N 980 550 980 610 {
lab=n3}
N 760 610 760 630 {
lab=#net1}
N 980 610 980 630 {
lab=n3}
N 700 660 720 660 {
lab=0}
N 700 660 700 710 {
lab=0}
N 700 710 760 710 {
lab=0}
N 760 690 760 710 {
lab=0}
N 920 660 940 660 {
lab=0}
N 920 660 920 710 {
lab=0}
N 920 710 980 710 {
lab=0}
N 980 690 980 710 {
lab=0}
N 760 710 760 730 {
lab=0}
N 980 710 980 730 {
lab=0}
N 690 100 760 100 {
lab=vdd}
N 580 360 580 390 {
lab=0}
N 580 250 580 300 {
lab=vdd}
N 730 130 730 170 {
lab=vdd}
N 730 130 760 130 {
lab=vdd}
N 980 170 1010 170 {
lab=vdd}
N 1010 130 1010 170 {
lab=vdd}
N 980 130 1010 130 {
lab=vdd}
N 730 170 760 170 {lab=vdd}
N 760 370 760 390 {lab=n2}
N 760 200 760 310 {lab=n2}
N 980 200 980 280 {lab=n3}
N 760 360 760 370 {lab=n2}
N 980 360 980 390 {lab=n3}
N 980 280 980 360 {lab=n3}
N 760 310 760 360 {lab=n2}
N 870 170 870 190 {lab=n1}
N 690 420 780 420 {lab=vdd}
N 960 420 1070 420 {lab=0}
N 1070 420 1070 450 {lab=0}
N 840 470 840 510 {lab=n2}
N 760 510 840 510 {lab=n2}
N 900 470 900 510 {lab=n3}
N 900 510 980 510 {lab=n3}
N 1170 170 1210 170 {lab=vdd}
N 1210 110 1210 170 {lab=vdd}
N 1210 100 1210 110 {lab=vdd}
N 980 100 1210 100 {lab=vdd}
N 1080 170 1130 170 {lab=n1}
N 1080 170 1080 230 {lab=n1}
N 930 230 1080 230 {lab=n1}
N 910 230 930 230 {lab=n1}
N 910 170 910 230 {lab=n1}
N 1170 100 1170 140 {lab=vdd}
N 1170 200 1170 380 {lab=vref}
N 1170 610 1170 630 {
lab=#net2}
N 1110 660 1130 660 {
lab=0}
N 1110 660 1110 710 {
lab=0}
N 1110 710 1170 710 {
lab=0}
N 1170 690 1170 710 {
lab=0}
N 1170 710 1170 730 {
lab=0}
N 1170 440 1170 610 {lab=#net2}
C {res.sym} 760 580 0 0 {name=R1
value=2k
footprint=1206
device=resistor
m=1}
C {lab_pin.sym} 690 100 0 0 {name=p1 sig_type=std_logic lab=vdd}
C {code_shown.sym} -510 140 0 0 {name=s1 only_toplevel=false 
value="
.option savecurrents
.control
  save all  
  dc temp -40 125 1
  write tt.raw vref
  quit
.endc
"}
C {vsource.sym} 580 330 0 0 {name=V1 value=1.8 savecurrent=false}
C {lab_pin.sym} 580 250 0 0 {name=p2 sig_type=std_logic lab=vdd}
C {sky130_fd_pr/pfet_01v8.sym} 960 170 0 0 {name=M1
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
C {sky130_fd_pr/pfet_01v8.sym} 780 170 0 1 {name=M3
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
C {sky130_fd_pr/pnp_05v5.sym} 740 660 0 0 {name=Q1
model=pnp_05v5_W3p40L3p40
m=8
spiceprefix=X
}
C {sky130_fd_pr/pnp_05v5.sym} 960 660 0 0 {name=Q2
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {lab_wire.sym} 870 170 0 0 {name=p3 sig_type=std_logic lab=n1}
C {lab_wire.sym} 760 390 0 0 {name=p4 sig_type=std_logic lab=n2}
C {lab_wire.sym} 980 390 0 0 {name=p5 sig_type=std_logic lab=n3}
C {two_stage.sym} 870 340 3 0 {name=x1}
C {lab_pin.sym} 690 420 0 0 {name=p6 sig_type=std_logic lab=vdd}
C {gnd.sym} 760 730 0 0 {name=l2 lab=0}
C {gnd.sym} 980 730 0 0 {name=l3 lab=0}
C {gnd.sym} 580 390 0 0 {name=l4 lab=0}
C {gnd.sym} 1070 450 0 0 {name=l5 lab=0}
C {sky130_fd_pr/corner.sym} -510 350 0 0 {name=CORNER only_toplevel=true corner=tt}
C {sky130_fd_pr/pfet_01v8.sym} 1150 170 0 0 {name=M2
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
C {res.sym} 1170 410 0 0 {name=R2
value=1350
footprint=1206
device=resistor
m=1}
C {sky130_fd_pr/pnp_05v5.sym} 1150 660 0 0 {name=Q3
model=pnp_05v5_W3p40L3p40
m=1
spiceprefix=X
}
C {gnd.sym} 1170 730 0 0 {name=l1 lab=0}
C {lab_pin.sym} 1170 310 0 1 {name=p7 sig_type=std_logic lab=vref}
C {launcher.sym} -240 10 0 0 {name=h5
descr="load waves"
tclcommand="xschem raw_read $netlist_dir/@schname\\\\.raw tran"
}
