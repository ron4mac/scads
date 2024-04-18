include <MyLib.scad>
use <rounded.scad>

/*[Box Dimensions]*/
cwidth = 100;
cdepth = 70;
cheight = 70;
wallth = 2;
wallrad = 4;
botrad = 0; //wallrad/2;
toprad = 0; //wallrad/2;
lidgap = 2;
vents = true;

/*[Hidden]*/
_lclr = .16;

module vent(_l) {
    hull() {
        cube([.1,_l,4]);
        translate([8,0,8]) cube([.1,_l,4]);
    }
}
difference() {
  allRoundedCube(cwidth,cdepth,cheight,wallrad,botrad);
  // interior of box
  translate([wallth,wallth,wallth]) allRoundedCube(cwidth-wallth*2,cdepth-wallth*2,cheight,wallrad-wallth,botrad);
  // vents
  if (vents) {
    translate([-1,cdepth/4,6]) vent(cdepth/2);
    translate([cwidth+1,cdepth/1.33,6]) rotate([0,0,180]) vent(cdepth/2);
    translate([cwidth/1.33,-1,6]) rotate([0,0,90]) vent(cwidth/2);
    translate([cwidth/4,cdepth+1,6]) rotate([0,0,270]) vent(cwidth/2);
  }
}

// lid
module lid() {
    if (wallrad) {
        translate([wallth+_lclr,wallth+_lclr,cheight-wallth-1])
            allRoundedCube(cwidth-wallth*2-_lclr*2,cdepth-wallth*2-_lclr*2,wallth+1,wallrad-wallth,0,0,true);
        if (lidgap) translate([0,0,cheight]) allRoundedCube(cwidth,cdepth,lidgap,wallrad,0,0,true);
    } else {
        translate([wallth+_lclr,wallth+_lclr,cheight-wallth-1])
            scube(cwidth-wallth*2-_lclr*2,cdepth-wallth*2-_lclr*2,wallth*3,wallth+1);
        if (lidgap) translate([0,0,cheight]) scube(cwidth,cdepth,wallth*4+_lclr,lidgap);
    }
    translate([0,0,cheight+lidgap]) allRoundedCube(cwidth,cdepth,wallth,wallrad,0,toprad);
}
rotate([180,0,0]) translate([0,5,-cheight-wallth-lidgap])
lid();