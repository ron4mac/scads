$fn = $preview ? 20 : 120;

hndl_h = 10;
hndl_w = 10;
hndl_l = 30;

key_d = 16.6;
key_h = 16;
wall = 3.2;
crh_h = 6;
tht_w = 2.7;
spk_h = crh_h+1;

module wedge () {
    _l = 20;
    hull() {
        cylinder(3, .1, .1);
        translate([-4,_l,0]) cylinder(3, .1, .1);
        translate([4,_l,0]) cylinder(3, .1, .1);
    }
}
module spoke () {
    //cube([key_d+1,tht_w,spk_h], true);
    wedge();
}
module spokes () {
    spoke();
    rotate([0,0,45]) spoke();
    rotate([0,0,90]) spoke();
    rotate([0,0,135]) spoke();
    rotate([0,0,180]) spoke();
    rotate([0,0,225]) spoke();
    rotate([0,0,270]) spoke();
    rotate([0,0,315]) spoke();
}
hull() {
    translate([0,hndl_l/2,0]) cylinder(hndl_h, d = hndl_w);
    translate([0,-hndl_l/2,0]) cylinder(hndl_h, d = hndl_w);
}

difference() {
    cylinder(key_h, d = key_d);
    translate([0,0,hndl_h]) cylinder(key_h, d = key_d-wall*2);
    translate([0,0,key_h-2/*+spk_h/4*/]) spokes();
}

//translate([0,0,spk_h/2]) spokes();
