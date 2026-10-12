v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 170 -20 170 40 {lab=Vdd}
N 340 -20 340 40 {lab=Vdd}
N 210 70 300 70 {lab=#net1}
N 140 70 170 70 {lab=Vdd}
N 140 20 140 70 {lab=Vdd}
N 140 20 170 20 {lab=Vdd}
N 340 70 370 70 {lab=Vdd}
N 370 20 370 70 {lab=Vdd}
N 340 20 370 20 {lab=Vdd}
N 170 100 170 160 {lab=#net1}
N 170 130 240 130 {lab=#net1}
N 240 70 240 130 {lab=#net1}
N 340 100 340 160 {lab=#net2}
N 170 220 170 250 {lab=#net3}
N 170 250 340 250 {lab=#net3}
N 340 220 340 250 {lab=#net3}
N 170 190 200 190 {lab=#net3}
N 200 190 200 240 {lab=#net3}
N 170 240 200 240 {lab=#net3}
N 310 240 340 240 {lab=#net3}
N 310 190 310 240 {lab=#net3}
N 310 190 340 190 {lab=#net3}
N 600 -20 600 40 {lab=Vdd}
N 100 -20 530 -20 {lab=Vdd}
N 480 70 560 70 {lab=#net2}
N 600 70 630 70 {lab=Vdd}
N 630 20 630 70 {lab=Vdd}
N 600 20 630 20 {lab=Vdd}
N 600 100 600 310 {lab=Vout}
N 100 410 530 410 {lab=Vss}
N 600 370 600 410 {lab=Vss}
N 260 370 260 410 {lab=Vss}
N 600 340 630 340 {lab=Vss}
N 630 340 630 390 {lab=Vss}
N 600 390 630 390 {lab=Vss}
N 260 340 290 340 {lab=Vss}
N 290 340 290 390 {lab=Vss}
N 260 390 290 390 {lab=Vss}
N 260 250 260 310 {lab=#net3}
N 580 130 600 130 {lab=Vout}
N 490 130 520 130 {lab=#net4}
N 400 70 480 70 {lab=#net2}
N 400 70 400 130 {lab=#net2}
N 340 130 400 130 {lab=#net2}
N 400 130 430 130 {lab=#net2}
N 530 -20 600 -20 {lab=Vdd}
N 530 410 600 410 {lab=Vss}
N 600 130 700 130 {lab=Vout}
N 700 130 700 220 {lab=Vout}
N 700 280 700 410 {lab=Vss}
N 600 410 700 410 {lab=Vss}
N -20 410 100 410 {lab=Vss}
N -20 -20 100 -20 {lab=Vdd}
N 50 370 50 410 {lab=Vss}
N 50 340 70 340 {lab=Vss}
N 70 340 80 340 {lab=Vss}
N 80 340 80 390 {lab=Vss}
N 50 390 80 390 {lab=Vss}
N 380 190 400 190 {lab=Vn}
N 110 190 130 190 {lab=Vp}
N 50 290 50 310 {lab=#net5}
N 50 190 50 230 {lab=#net6}
N -20 190 50 190 {lab=#net6}
N -20 190 -20 340 {lab=#net6}
N -20 340 10 340 {lab=#net6}
N -20 340 -20 380 {lab=#net6}
N -20 380 180 380 {lab=#net6}
N 180 340 180 380 {lab=#net6}
N 180 340 220 340 {lab=#net6}
N 50 160 50 190 {lab=#net6}
N 50 -20 50 100 {lab=Vdd}
N 480 340 560 340 {lab=#net7}
N 440 370 440 410 {lab=Vss}
N 410 340 440 340 {lab=Vss}
N 410 340 410 390 {lab=Vss}
N 410 390 440 390 {lab=Vss}
N 440 290 440 310 {lab=#net7}
N 440 290 510 290 {lab=#net7}
N 510 290 510 340 {lab=#net7}
N 510 270 510 290 {lab=#net7}
N 510 -20 510 210 {lab=Vdd}
C {ipin.sym} -20 -20 0 0 {name=p1 lab=Vdd}
C {opin.sym} 700 130 0 0 {name=p3 lab=Vout}
C {ipin.sym} -20 410 0 0 {name=p2 lab=Vss}
C {sky130_fd_pr/pfet_01v8.sym} 190 70 0 1 {name=M1
W=7.2
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
C {sky130_fd_pr/nfet_01v8.sym} 150 190 0 0 {name=M2
W=0.66
L=0.15
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
C {sky130_fd_pr/pfet_01v8.sym} 320 70 0 0 {name=M3
W=7.2
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
C {sky130_fd_pr/nfet_01v8.sym} 360 190 0 1 {name=M4
W=0.66
L=0.15
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
C {sky130_fd_pr/pfet_01v8.sym} 580 70 0 0 {name=M5
W=30
L=0.30
nf=1
mult=2
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {capa.sym} 550 130 1 0 {name=C1
m=1
value=2p
footprint=1206
device="ceramic capacitor"}
C {res.sym} 460 130 1 0 {name=R1
value=9k
footprint=1206
device=resistor
m=1}
C {capa.sym} 700 250 2 0 {name=C2
m=1
value=5p
footprint=1206
device="ceramic capacitor"}
C {ipin.sym} 110 190 0 0 {name=p4 lab=Vp}
C {ipin.sym} 400 190 0 1 {name=p5 lab=Vn}
C {res.sym} 50 260 2 0 {name=R2
value=26k
footprint=1206
device=resistor
m=1}
C {res.sym} 50 130 2 0 {name=R3
value=54k
footprint=1206
device=resistor
m=1}
C {sky130_fd_pr/nfet_01v8.sym} 30 340 0 0 {name=M6
W=5
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
C {sky130_fd_pr/nfet_01v8.sym} 240 340 0 0 {name=M7
W=5
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
C {sky130_fd_pr/nfet_01v8.sym} 460 340 0 1 {name=M8
W=5
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
C {sky130_fd_pr/nfet_01v8.sym} 580 340 0 0 {name=M9
W=5
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
C {isource.sym} 510 240 0 0 {name=I0 value=75u}
