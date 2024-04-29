module utl_mirror (axis)
{
	children();
	mirror(axis) children();
}

// distribute objects (children) to 4 corners of a rectangle
module utl_distRectangle (w, d, r, ox=0, oy=0, oz=0, rot=false)
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

// distribute objects (children) evenly around a circle to number of places 
module utl_distCircle (r, n, ox=0, oy=0, oz=0, rot=false)
{
	ai = 360/n;
	for (a=[0:ai:360-ai]) {
		x = ox + cos(a)*r;
		y = oy + sin(a)*r;
		if (rot) {
			translate([x,y,oz]) rotate([0,0,a]) children();
		} else {
			translate([x,y,oz]) children();
		}
	}
}

module utl__distLinear (n=0, l=0, ow=0, v=[1,0,0])
{
	assert(n||ow, "Linear number and offset width can not both be zero");
	_n = n ? n : floor(l/ow);
	_ow = n ? l/(n-1) : ow;
	for (i =[0:1:_n-1]) translate([i*v[0]*_ow,i*v[1]*_ow,i*v[2]*_ow]) children();
}

// distribute objects (children) in a linear fashion
// number of iterations placed toward a vector point
module utl_distLinear (n, v)
{
	_n = n-1;
	ox = v[0]/_n;
	oy = v[1]/_n;
	oz = v[2]/_n;
	for (i =[0:1:_n]) translate([i*ox,i*oy,i*oz]) children();
}