$fn = 64;
cylinder($fn=64, d=30, h=10);

$fn = 18;
translate([0,0,9.6]) difference() {
    cylinder(d=9.6, h=40);
    cylinder(d=6, h=50);
}
