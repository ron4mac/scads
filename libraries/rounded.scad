use <utils.scad>

// a simple rounded rectangle
module rrect (w, d, r)
{
	translate([r,r]) offset(r) square([w-r*2,d-r*2]);
}

// rectangular circle group
module crect (w, d, r)
{
	utl_distRectangle(w,d,r,r,r) circle(r);
}

// an open "cube" made of cylinder corners
module ccube (w, d, r, h)
{
	utl_distRectangle(w,d,r,r,r) cylinder(h,r,r);
}

// an open "cube" made of cube corners
module scube (w, d, r, h)
{
	utl_distRectangle(w,d,r) cube([r,r,h]);
}

// create a cube rounded on its vertical corners
module roundedCube (width, depth, height, radius)
{
	linear_extrude(height) hull() rrect(width,depth,radius);
}

module sphereRaft (w, d, r, bot=false)
{
	translate([0,0,bot?r:0]) difference() {
		hull() utl_distRectangle(w,d,r,r,r) sphere(r);
		translate([w/2,d/2,bot?r/2:-r/2]) cube([w,d,r], true);
	}
}

// create a cube rounded on its vertical corners and, optionally, its horizontal bottom and/or top edges
module allRoundedCube (width, depth, height, radius, botrad=0, toprad=0, noh=false)
{
	brad = min(botrad,height/2);
	trad = min(toprad,height/2);

	if (brad) {
		hull() {
			iset = (brad < radius) ? radius-brad : 0;
			translate([iset/2,iset/2,0]) sphereRaft(width-iset,depth-iset,brad,true);
			translate([0,0,brad-.01]) linear_extrude(.01) rrect(width,depth,radius);
		}
	}

	if (trad) {
		hull() {
			iset = (trad < radius) ? radius-trad : 0;
			translate([iset/2,iset/2,height-trad]) sphereRaft(width-iset,depth-iset,trad);
			translate([0,0,height-trad]) linear_extrude(.01) rrect(width,depth,radius);
		}
	}

	if (noh) {
		translate([0,0,brad]) ccube(width,depth,radius,height-brad-trad);	//linear_extrude(height-brad-trad) crect(width,depth,radius);
	} else {
		translate([0,0,brad+(brad?-.01:0)]) linear_extrude(height-brad-trad+(trad?.01:0)) hull() rrect(width,depth,radius);
	}
}
