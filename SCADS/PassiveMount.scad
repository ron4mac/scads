$fn = 128;

module mount() {
    difference() {
        cylinder(d=61.2, h=3);
        translate([0,0,1.6]) cylinder(d=58, h=2);
    }
}

difference() {
    mount();
    translate([0,0,-1]) cylinder(d=48, h=5);
    translate([26,0,-1]) cylinder(d=2.4, h=5);
    translate([0,26,-1]) cylinder(d=2.4, h=5);
    translate([-26,0,-1]) cylinder(d=2.4, h=5);
    translate([0,-26,-1]) cylinder(d=2.4, h=5);
}