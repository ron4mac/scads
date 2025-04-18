include <MyLib.scad>
include <box.scad>

/* [Show Box Parts] */
bxv_show_box = true;
bxv_show_lid = true;
bxv_lid_on_box = false;

/*[Box Type]*/
bxv_type = 0; //[0:Cover,1:SnapCover,2:SlideCover,3:PegCover]

/*[Box Dimensions]*/
// box outside width
bxv_width = 140;
// box outside width
bxv_depth = 100;
// total box height
bxv_height = 35;
// box wall thickness
bxv_thick = 2.4;  // [1.2:.2:5]
// vertical corners raduis
bxv_radius = 1;
// box lid height (0 = no lid)
bxv_lid_height = 7.4;  // [1.2:.2:20]

botrad = 2; //wallrad/2;
toprad = 2; //wallrad/2;

module wallRib (x,y) {
	translate([x,y,0]) square([1.2, bxv_height - bxv_lid_height]);
}

module bx_hook_boxAdds ()
{
    bx_addFront(bxv_thick*2)
    {
        xoff = bxv_depth/4;
        wallRib(xoff, bxv_thick);
        wallRib(bxv_depth-xoff, bxv_thick);
    }
    bx_addBack(bxv_thick*2)
    {
        xoff = bxv_depth/4;
        wallRib(xoff, bxv_thick);
        wallRib(bxv_depth-xoff, bxv_thick);
    }
    bx_addRight(bxv_thick*2)
    {
        xoff = bxv_width/4;
        wallRib(xoff, bxv_thick);
        wallRib(bxv_width-xoff, bxv_thick);
    }
    bx_addLeft(bxv_thick*2)
    {
        xoff = bxv_width/4;
        wallRib(xoff, bxv_thick);
        wallRib(bxv_width-xoff, bxv_thick);
    }
}

bx_generate(botrad=botrad, toprad=toprad);
