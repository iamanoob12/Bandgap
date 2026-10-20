v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -140 -140 170 -140 {lab=Vdd}
N -0 -140 -0 -110 {lab=Vdd}
N -30 -80 0 -80 {lab=Vdd}
N -30 -120 -30 -80 {lab=Vdd}
N -30 -120 -0 -120 {lab=Vdd}
N -100 -30 -40 -30 {lab=#net1}
N -100 -30 -100 -0 {lab=#net1}
N -30 -30 110 -30 {lab=#net1}
N 110 -30 110 0 {lab=#net1}
N -170 30 -140 30 {lab=V+}
N 150 30 190 30 {lab=V-}
N -100 30 -60 30 {lab=#net1}
N -60 -10 -60 30 {lab=#net1}
N -100 -10 -60 -10 {lab=#net1}
N 70 30 110 30 {lab=#net1}
N 70 -10 70 30 {lab=#net1}
N 70 -10 110 -10 {lab=#net1}
N 110 60 110 110 {lab=Vout}
N -100 60 -100 110 {lab=#net2}
N -100 90 -0 90 {lab=#net2}
N -60 140 -40 140 {lab=#net2}
N -30 140 70 140 {lab=#net2}
N -0 -50 -0 -30 {lab=#net1}
N 0 90 -0 140 {lab=#net2}
N -40 -30 -30 -30 {lab=#net1}
N -40 140 -30 140 {lab=#net2}
N -100 170 -100 210 {lab=Vss}
N -100 210 110 210 {lab=Vss}
N 110 170 110 210 {lab=Vss}
N 110 140 140 140 {lab=Vss}
N 140 140 140 180 {lab=Vss}
N 110 180 140 180 {lab=Vss}
N -130 180 -100 180 {lab=Vss}
N -130 140 -130 180 {lab=Vss}
N -130 140 -100 140 {lab=Vss}
N -130 210 -100 210 {lab=Vss}
N 40 -80 70 -80 {lab=Vb}
C {sky130_fd_pr/pfet_01v8.sym} 20 -80 0 1 {name=M1
W=16
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
C {sky130_fd_pr/pfet_01v8.sym} -120 30 0 0 {name=M2
W=16
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
C {sky130_fd_pr/pfet_01v8.sym} 130 30 0 1 {name=M3
W=16
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
C {ipin.sym} -140 -140 0 0 {name=p1 lab=Vdd}
C {opin.sym} 110 80 0 0 {name=p3 lab=Vout}
C {ipin.sym} -170 30 0 0 {name=p2 lab=V+}
C {ipin.sym} 190 30 0 1 {name=p4 lab=V-}
C {sky130_fd_pr/nfet_01v8.sym} 90 140 0 0 {name=M4
W=4
L=0.50
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} -80 140 0 1 {name=M5
W=4
L=0.50
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {ipin.sym} -130 210 0 0 {name=p5 lab=Vss}
C {ipin.sym} 70 -80 0 1 {name=p6 lab=Vb}
