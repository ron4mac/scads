module utl_mirror (axis)
{
	children();
	mirror(axis) children();
}

// distribute objects (children) to 4 corners
module utl_distr4 (w, d, r, ox=0, oy=0, oz=0, rot=false)
{
	translate([ox,oy,oz]) children();
	if (rot) {
		translate([w-r,oy,oz]) rotate([0,0,90]) children();
		translate([w-r,d-r,oz]) rotate([0,0,180]) children();
		translate([ox,d-r,oz]) rotate([0,0,270]) children();
	} else {
		translate([w-r,oy,oz]) children();
		translate([w-r,d-r,oz]) children();
		translate([ox,d-r,oz]) children();
	}
}
