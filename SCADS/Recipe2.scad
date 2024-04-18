
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
module base(r) {
    bW = 20;
    cube([bD,bW,bH]);
    translate([bD-sE+4.7,0,bH]) cube([sE-4.7,bW,bH]);
    lrp = r ? bW-2.4 : 0;
    translate([30,lrp,bH]) cube([25,2.4,80]);
    translate([bD-sE+13.3,0,bH+bH]) cube([sE-13.3,bW,bH+2.2]);
}
module bases() {
    base();
    translate([0,22,0]) base(true);
}
module stand(fat) {
    cube([bH,sW,sH]);
    cube([sE-1,sW,bH]);
    if (fat) translate([0,0,9]) cube([20,sW,80]);
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
        translate([bD-sE,-1,bH-1]) rotate([0,A,0]) stand(true);
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
ddifference() {
    stando();
    //grate(18,148,4,6);
    #translate([sH-20,sW/2,-.4]) rotate([0,0,-90]) linear_extrude(3) text("    ", 22, font="Webdings", halign="center", valign="center",$fn=64);    
    #translate([sH-60,sW/2,1]) rotate([0,0,-90]) linear_extrude(3) text("FROM OUR", 18, font="Arial Black", halign="center", valign="center",$fn=64);
    #translate([sH-90,sW/2,1]) rotate([0,0,-90]) linear_extrude(3) text("KITCHEN", 24, font="Arial Black", halign="center", valign="center",$fn=64);
    #translate([sH-120,sW/2,1]) rotate([0,0,-90]) linear_extrude(3) text("TO YOU", 18, font="Arial Black", halign="center", valign="center",$fn=64);
    #translate([sH-160,sW/2,-.4]) rotate([0,0,-90]) linear_extrude(3) text("    ", 22, font="Webdings", halign="center", valign="center",$fn=64);    
}