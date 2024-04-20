include <MyLib.scad>
include <box.scad>

/* [Show Box Parts] */
bx_show_box = true;
bx_show_lid = true;
bx_lid_on_box = false;

/* [Box Type] */
bx_type = 1; //[0:Cover,1:SnapCover,2:SlideCover,3:PegCover]

/* [Box Dimensions] */
bx_width = 80;
bx_depth = 60;
bx_height = 50;
bx_lid_height = 9.4;//11;
bx_thick = 2;   // [1.2:.2:5]

/* [Box Layout] */
bx_cols = 4;    // [0:1:10]
bx_rows = 3;    // [0:1:10]
bx_no_col_wall = [[2,0]];
bx_no_row_wall = [[0,0],[0,1],[1,2]];
bx_radius = 2;  // [0:.2:5]

//botrad = wallrad/2; //[ 0,wallrad/2]
//toprad = wallrad/2; //[ 0,wallrad/2]
//lidgap = 0;

Bx_Generate() {
    Bx_Cut_Left(bx_thick/2) {
        translate([20,20]) circle(10);
        translate([40,10]) square([20,5]);
    }
    Bx_Cut_Left() translate([20,20]) circle(5);
    Bx_Cut_Right(bx_thick/2) {
        translate([20,20]) circle(10);
        translate([40,10]) square([20,5]);
    }
    Bx_Cut_Back(bx_thick/2) translate([20,20]) circle(10);
    Bx_Cut_Front(bx_thick/2)
    {
        translate([20,20]) circle(10);
        translate([20,20]) square([24,5],true);
    }
}
