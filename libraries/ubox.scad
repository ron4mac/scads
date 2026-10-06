include <MyLib.scad>;
include <Ultimate_Box_Generator.3.10.scad>;

show_box = false;
show_lid = false;

module make__ubox () {
	difference() {
	    make_box();
		translate([wall,comp_size_y+wall*2,0]) rotate([90,0,-90]) cutsLeft();
		translate([comp_size_x+wall,0,0]) rotate([90,0,90]) cutsRight();
		translate([0,wall,0]) rotate([90,0,0]) cutsFront();
		translate([comp_size_x+wall*2,comp_size_y+wall,0]) rotate([90,0,180]) cutsBack();
		translate([0,0,0]) cutsBottom();
	}
}

module make_ubox () {
    make__ubox();
	translate([0,comp_size_y+wall*2,0]) rotate([90,0,-90]) addsLeft();
	translate([comp_size_x+wall*2,0,0]) rotate([90,0,90]) addsRight();
	rotate([90,0,0]) addsFront();
	translate([comp_size_x+wall*2,comp_size_y+wall*2,0]) rotate([90,0,180]) addsBack();
	translate([0,0,wall]) addsBottom();
}

module make__ulid () {
	difference() {
	    make_lid();
		cutsLid();
	}
}

module make_ulid () {
    make__ulid();
	addsLid();
}


module addsLeft () {}
module addsRight () {}
module addsFront () {}
module addsBack () {}
module addsBottom () {}

module cutsLeft () {}
module cutsRight () {}
module cutsFront () {}
module cutsBack () {}
module cutsBottom () {}

module addsLid () {}
module cutsLid () {}
