include <MyLib.scad>
include <box.scad>

/* [Show Box Parts] */
bxv_show_box = true;
bxv_show_lid = true;
bxv_lid_on_box = false;

/*[Box Type]*/
bxv_type = 3; //[0:Cover,1:SnapCover,2:SlideCover,3:PegCover]

/*[Box Dimensions]*/
// box outside width
bxv_width = 100;
// box outside width
bxv_depth = 70;
// total box height
bxv_height = 70;
// box wall thickness
bxv_thick = 2;  // [1.2:.2:5]
// vertical corners raduis
bxv_radius = 2;
// box lid height (0 = no lid)
bxv_lid_height = 5;  // [1.2:.2:20]
// space between lid and box
bxv_lid_gap = 3;

botrad = 1; //wallrad/2;
toprad = 1; //wallrad/2;
vents = true;

module vent (_l)
{
    d = bxv_thick+.01;
    hull() {
        cube([_l,.01,4]);
        translate([0,d,d]) cube([_l,.01,4]);
    }
}

module bx_hook_boxCuts ()
{
    if (vents) {
        bx_cutLeft(0) translate([bxv_width/4,-.01,8]) vent(bxv_width/2);
        bx_cutRight(0) translate([bxv_width/4,-.01,8]) vent(bxv_width/2);
        bx_cutBack(0) translate([bxv_depth/4,-.01,8]) vent(bxv_depth/2);
        bx_cutFront(0) translate([bxv_depth/4,-.01,8]) vent(bxv_depth/2);
    }
}

bx_generate(botrad=botrad, toprad=toprad);
