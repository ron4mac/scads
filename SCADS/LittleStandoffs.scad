$fn = 64;

module standoff() {
    difference() {
        cylinder (d=6,h=5,center=true);
        translate([0,0,-1]) cylinder (d=2.75,h=8,center=true);
    }
}

translate([10,10]) standoff();
translate([10,20]) standoff();
translate([10,30]) standoff();
translate([10,40]) standoff();

translate([20,10]) standoff();
translate([20,20]) standoff();
translate([20,30]) standoff();
translate([20,40]) standoff();
