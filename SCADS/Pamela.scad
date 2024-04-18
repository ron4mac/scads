$fn = 64;
/*
fl = 55;
fw = 14;
fr = fw/2;

difference() {
    hull() {
        cube([fl,fw,2]);
        translate([fl,fr,0]) cylinder(2,fr,fr);
    }
    translate([fl,fr,-.5]) cylinder(3,5,5);
}
#translate([1.2,1.4,2]) linear_extrude(2) text("Pamela",size=11,font="Comic Sans MS");
*/

fl = 55;
fw = 14;
fr = fw/2;

difference() {
    hull() {
        cube([fl,fw,3]);
        translate([fl,fr,0]) cylinder(3,fr,fr);
    }
    translate([fl,fr,-.5]) cylinder(4,4.2,4.2);
    translate([1.2,1.4,2.1]) linear_extrude(1,4) text("Ronnie",size=11,font="Comic Sans MS");
    translate([47.6,1.4,.9]) rotate([0,180,0]) linear_extrude(1,4) text("Ronnie",size=11,font="Comic Sans MS");
}

