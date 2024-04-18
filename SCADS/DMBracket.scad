$fn = 64;

wallT = 4;
clrT = 2;
lipH = 184/8;

dm_h = 184;
dm_d = 110 + clrT + clrT;

h_wid = dm_d+wallT+wallT;
brk_d = dm_d + 40;

bop_w = h_wid - 36;

module ublock() {
    union() {
        cylinder(lipH, d = h_wid, true);
        //translate([h_wid/2, 0, lipH+lipH/2]) cube([h_wid,h_wid,lipH*3]);
        translate([0, -h_wid/2, 0]) cube([h_wid-39,h_wid,lipH*3]);
    }
}

module carve() {
    difference() {
        ublock();
        translate([0,0,wallT-1]) cylinder(lipH, d = dm_d, true);
        //translate([h_wid/2, 0, lipH+lipH/2+wallT]) cube([h_wid,h_wid-wallT-wallT,lipH*3], true);
        translate([0, -h_wid/2+wallT, wallT-1]) cube([h_wid-wallT-39,h_wid-wallT-wallT,lipH*3]);
        translate([0, -h_wid/2-wallT, lipH/2+12]) rotate([0,-30,0]) cube([h_wid+30,h_wid+wallT+wallT,lipH*2]);
        translate([h_wid-64, -bop_w/2, -wallT]) cube([52,bop_w,lipH*4]);
        translate([36,14,-.2]) cylinder(6, d=14, true);
        translate([-36,14,-.2]) cylinder(6, d=14, true);
        translate([36,-14,-.2]) cylinder(6, d=14, true);
        translate([-36,-14,-.2]) cylinder(6, d=14, true);
        translate([14,36,-.2]) cylinder(6, d=14, true);
        translate([-14,36,-.2]) cylinder(6, d=14, true);
        translate([14,-36,-.2]) cylinder(6, d=14, true);
        translate([-14,-36,-.2]) cylinder(6, d=14, true);
        translate([77,50,62]) rotate([0,90,0]) cylinder(8, d=5, true);
        translate([77,-50,62]) rotate([0,90,0]) cylinder(8, d=5, true);
    }
}


module ray() {
    cube([2,110,2], true);
}

module tray() {
    ray();
rotate([0,0,45]) ray();
rotate([0,0,90]) ray();
rotate([0,0,135]) ray();
}

translate([0,0,4]) tray();

//ublock();
carve();

//translate([0, -h_wid/2-wallT, lipH/2+24]) rotate([0,-30,0]) cube([h_wid,h_wid+wallT+wallT,lipH*2]);
//translate([h_wid-50, -45, -wallT]) cube([52,h_wid-wallT*8,lipH*3]);