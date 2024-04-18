$fn = 64;
pihd = 2.75;
pihh = 20;
padh = 2.2;
soh = 5;
difference() {
    union() {
        // main body
        cube([65,56,padh], false);
        // standoff arms
        translate([0,-8]) cube([8,8,padh], false);
        translate([0,56]) cube([8,8,padh], false);
        translate([57,56]) cube([8,8,padh], false);
        translate([57,-8]) cube([8,8,padh], false);
        // build mount standoffs
        translate([4,-4]) cylinder(soh,d=6);
        translate([4,60]) cylinder(soh,d=6);
        translate([61,60]) cylinder(soh,d=6);
        translate([61,-4]) cylinder(soh,d=6);
    }
    // do all the screw holes and empty middle
    // pi mount holes
    translate([3.5,3.5]) cylinder(h=pihh, d=pihd, center=true);
    translate([3.5,52.5]) cylinder(h=pihh, d=pihd, center=true);
    translate([61.5,52.5]) cylinder(h=pihh, d=pihd, center=true);
    translate([61.5,3.5]) cylinder(h=pihh, d=pihd, center=true);
    // stand off mount holes
    translate([4,-4]) cylinder(h=pihh, d=pihd, center=true);
    translate([4,60]) cylinder(h=pihh, d=pihd, center=true);
    translate([61,60]) cylinder(h=pihh, d=pihd, center=true);
    translate([61,-4]) cylinder(h=pihh, d=pihd, center=true);
    // remove middle
    translate([8,8,-1]) cube([49,40,pihh]);
}
