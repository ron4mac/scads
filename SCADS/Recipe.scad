
bH = 2;
bD = 70;
sW = 180;
sH = 180;
sD = 3;
sE = 15;
A = -12;

module vent(vD,vW,vH) {
    cube([vH,vW,vD]);
}

module grate(oW,oH,oD,cnt) {
    for (i = [1:cnt]) {
        translate([16,i*28-17,-.5]) vent(oD,oW,oH);
    }
}
module base() {
    bW = 20;
    cube([bD,bW,bH]);
    translate([bD-sE+4.7,0,bH]) cube([sE-4.7,bW,bH]);
    translate([bD-sE+13.3,0,bH+bH]) cube([sE-13.3,bW,bH+.4]);
}
module bases() {
    base();
    translate([0,22,0]) base();
}
module stand() {
    cube([bH,sW,sH]);
    cube([sE-1,sW,bH]);
}
module stando() {
    cube([sH,sW,bH]);
    cube([bH,sW,sE-1]);
}
module carves() {
}
module carveb() {
    difference() {
        bases();
        translate([bD-sE,-1,bH-1]) rotate([0,A,0]) stand();
    }
}

module fulls() {
    base();
    translate([bD-sE,0,bH-1]) rotate([0,A,0]) stand();
}

//stand();
carveb();
//fulls();
//stando();
//difference() {
//    stando();
//    grate(18,148,4,6);
//}