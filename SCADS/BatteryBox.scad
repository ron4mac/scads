include <MyLib.scad>
include <box.scad>

/* [Show Box Parts] */
bxv_show_box = true;
bxv_show_lid = true;
bxv_lid_on_box = false;

/* [Box Type] */
bxv_type = 0; //[0:Cover,1:SnapCover,2:SlideCover,3:PegCover]

/* [Box Dimensions] */
bxv_width = 210;
bxv_depth = 100;
bxv_height = 38;
bxv_lid_height = 7;	//.4;//11;
bxv_thick = 2;	// [1.2:.2:5]

/* [Box Layout] */
bxv_cols = 4;	// [0:1:10]
bxv_rows = 5;	// [0:1:10]
//bxv_no_col_wall = [
//	[0,0],[0,1],[0,2],[0,3],
//	[1,0],[1,1],[1,2],[1,3],
//	[2,0],[2,1],[2,2],[2,3],
//];
bxv_blocks = [
	[0,0,1,5],[1,0,1,5],[2,0,1,5]
];
//bxv_no_row_wall = [[0,0],[0,1],[0,2]];
bxv_radius = 2;	// [0:.2:5]

//botrad = wallrad/2; //[ 0,wallrad/2]
//toprad = wallrad/2; //[ 0,wallrad/2]
//lidgap = 0;

module bx_hook_boxCuts ()
{
//	bx_cutLeft(bxv_thick/2) {
	//	translate([20,20]) circle(10);
	//	translate([40,10]) square([20,5]);
//	}
	//bx_cutLeft() translate([20,20]) circle(5);
	//bx_cutLeft(.4) translate([bxv_width/2,(bxv_height-bxv_lid_height)/2]) text("MY STUFF",8,halign="center");
//	bx_cutRight(bxv_thick/2) {
	//	translate([20,20]) circle(10);
	//	translate([40,10]) square([20,5]);
//	}
	//bx_cutBack(bxv_thick/2) translate([20,20]) circle(10);
//	bx_cutFront(bxv_thick/2) {
	//	translate([20,20]) circle(10);
	//	translate([20,20]) square([24,5],true);
//	}
}
module bx_hook_boxAdds ()
{
	//bx_addLeft(.4) translate([35,20]) text("COOL!",8);
}
module bx_hook_lidCuts ()
{
	//bx_cutTop() translate([45,15]) square([10,10]);
}
module bx_hook_lidAdds ()
{
	//translate([10,10,bxv_thick]) cube([10,10,10]);
}

bx_generate();