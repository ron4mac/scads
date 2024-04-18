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
bx_thick = 2.4;   // [1.2:.2:5]

/* [Box Layout] */
bx_cols = 4;    // [0:1:10]
bx_rows = 3;    // [0:1:10]
bx_no_col_wall = [[2,0]];
bx_no_row_wall = [[0,0],[0,1],[1,2]];
bx_radius = 2;  // [0:.2:5]

/*[Box Dimensions]*/
//bwidth = 80;
//bdepth = 60;
//bheight = 30;
//lheight = 7;
//wallth = 2; // [2:.1:4]
//wallrad = 4;    // [0:.1:5]
//botrad = wallrad/2; //[ 0,wallrad/2]
//toprad = wallrad/2; //[ 0,wallrad/2]
//lidtype = snap_type;    // [0:peg_type,1:snap_type,2:cover_type,3:slide_type]
//lidgap = 0;

//translate([-bwidth-5,0,0])
//    box(bwidth,bdepth,bheight,wallth,lheight,lidpeg,lidgap);

//difference() {
    roundedBox();
    //roundedBox(bwidth,bdepth,bheight,wallth,wallrad,botrad,toprad,lheight,lidtype,lidgap);
//    translate([bx_width/2-10,-100,0]) cube([100,1000,100]);
//}

//translate([0,0,60]) allRoundedCube (30, 30, 20, 2, 2);