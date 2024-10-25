include <MyLib.scad>
include <box.scad>
include <utils.scad>

/* [Show Box Parts] */
bxv_show_box = true;
bxv_show_lid = false;
bxv_lid_on_box = false;

/*[Box Type]*/
bxv_type = 3; //[0:Cover,1:SnapCover,2:SlideCover,3:PegCover]

/*[Box Dimensions]*/
// box outside width
bxv_width = 200;
// box outside width
bxv_depth = 220;
// total box height
bxv_height = 30;
// box wall thickness
bxv_thick = 2.4;  // [1.2:.2:5]
// vertical corners raduis
bxv_radius = 0;
// box lid height (0 = no lid)
bxv_lid_height = 0;  // [1.2:.2:20]

// box rows and columns
//bxv_rows = 6;

botrad = 0; //wallrad/2;
toprad = 0; //wallrad/2;

shelves = 4;
shelfoff = (bxv_depth)/(shelves);

module bx_hook_boxCuts ()
{
    translate([12,bxv_depth-12,-1]) cylinder(10,3,3);
    translate([bxv_width-12,bxv_depth-12,-1]) cylinder(10,3,3);
}

module shelf (wid)
{
    difference() {
        //cube([bxv_width-bxv_thick*2, bxv_thick, bxv_height]);
        allRoundedCube (wid, bxv_thick, bxv_height+6, 0, botrad=0, toprad=1);
        utl_distLinear(30, [bxv_width,0,0]) {
            translate([3,-1,bxv_height]) cube([3,6,3]);
        }
    }
}

*bx_generate(botrad=botrad, toprad=toprad);

*utl_distLinear(shelves, [0,bxv_depth-shelfoff*2+52.6,0]) {
    translate([bxv_thick,shelfoff]) shelf(bxv_width-bxv_thick*2);
//    difference() {
//        //cube([bxv_width-bxv_thick*2, bxv_thick, bxv_height]);
//        allRoundedCube (bxv_width-bxv_thick*2, bxv_thick, bxv_height+6, 0, botrad=0, toprad=1);
//        utl_distLinear(30, [bxv_width,0,0]) {
//            translate([3,-1,bxv_height]) cube([3,6,3]);
//        }
//    }
}

pegld = 25;
*translate([0,-pegld]) cube([bxv_width, pegld, bxv_thick]);

*utl_distLinear(10, [bxv_width-18,0,0]) {
    translate([8,-pegld+7]) cylinder(bxv_height/1.4,3.6,3.6);
    translate([8,-pegld+7,bxv_height/1.4]) cylinder(3,3.6,5.2);
}

//rotate ([90,0,0]) shelf(43);

// glue-on lip for lower shelf
*translate ([0,-50,0]) {
    difference () {
        cube([bxv_width+2,12,bxv_thick]);
        translate([.8,.8,1.2]) cube([bxv_width+.4,12,3]);
    }
}

rpegld = 25;
translate([0,-rpegld*2]) difference () {
    cube([bxv_width, rpegld, bxv_thick]);
    translate([18,18,-.1]) cylinder(3,3,3);
    translate([bxv_width-19,18,-.1]) cylinder(3,3,3);
}

utl_distLinear(10, [bxv_width-17,0,0]) {
    translate([8,-rpegld*2+7,1.4]) rotate([-12,0,0]) {
        cylinder(bxv_height+8,4,4);
        translate([0,0,38]) sphere(4);
    }
    translate([6.5,-43.6,0]) cube([3,6,10]);
}
