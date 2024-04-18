$fn = 64;
// box material thickness (1/2" plywood)
bxmthk = 5;
// width of box
bxw = 220;
// height of box
bxh = 75;  //178;
// depth of box
bxd = 80;
//inner section height
insh = bxh-bxmthk-bxmthk;
//inner section depth
insd = bxd-bxmthk-bxmthk;
// speaker hole diameter
spkhd = 40.4;
// speaker mount diameter
spkmd = 50.8;

module frontpanel() {
    color("maroon") cube([bxmthk,bxw,bxh]);
    translate([-7.2, bxh/2, bxh/2])
        rotate([0,90,0]) cylinder(d=spkmd,h=7.2);
    translate([-7.2, bxw - bxh/2, bxh/2])
        rotate([0,90,0]) cylinder(d=spkmd,h=7.2);
}

// front face
difference() {
    frontpanel();
    translate([-1,insh/2 + bxmthk,insh/2 + bxmthk])
        rotate([0,90,0]) cylinder(d=spkhd,h=400,center=true);
    translate([-1,bxw - insh/2 - bxmthk,insh/2 + bxmthk])
        rotate([0,90,0]) cylinder(d=spkhd,h=400,center=true);
}

// top
translate([bxmthk,0,bxh-bxmthk])
    color("red")
        cube([bxd-bxmthk,bxw,bxmthk]);
// left and right sides
translate([bxmthk,0,0])
    color("yellow")
        cube([bxd-bxmthk,bxmthk,bxh-bxmthk]);
translate([bxmthk,bxw-bxmthk,0])
    color("yellow")
        cube([bxd-bxmthk,bxmthk,bxh-bxmthk]);
// inner sections
translate([bxmthk,insh+bxmthk,bxmthk])
    color("gray")
        cube([insd,bxmthk,insh]);
translate([bxmthk,bxw-insh-bxmthk-bxmthk,bxmthk])
    color("gray")
        cube([insd,bxmthk,insh]);

// bottom and back
translate([bxmthk,bxmthk,0])
    color([0,0,100,1.0])
        cube([insd,bxw-bxmthk-bxmthk,bxmthk]);
translate([40+insd+bxmthk,bxmthk,0])
    color([0,100,0,0.3])
        cube([bxmthk,bxw-bxmthk-bxmthk,bxh-bxmthk]);

echo(insh=insh,insd=insd);