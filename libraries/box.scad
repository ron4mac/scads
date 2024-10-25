use <utils.scad>
use <rounded.scad>

// box dimensions
bxv_width = 80;
bxv_depth = 60;
bxv_height = 30;
bxv_thick = 2.4;
bxv_lid_height = 8;
bxv_lid_gap = 0;

// the type of box to generate
bxv_type = bxc_type_cover;
// box exterior edge radius
bxv_radius = 3;

// box rows and columns
bxv_cols = 1;
bxv_rows = 1;
bxv_no_col_wall = [];
bxv_no_row_wall = [];

// show box parts
bxv_show_box = true;
bxv_show_lid = true;

// internal constants
bxc_clr = .16;	// parts clearance
bxc_pegH = 3;	// lid peg height
bxc_pegT = 4;	// lid peg thickness
bxc_bxColor = "BurlyWood";
bxc_pegColor = "Coral";
// lid cover/snap area
bxc_ridgeH = 5;		// ridge space height
bxc_snapVert = 2;	// lid snap vertical position
bxc_snapColor = "White";
// lid types
bxc_type_cover = 0;
bxc_type_snap = 1;
bxc_type_slide = 2;
bxc_type_peg = 3;


module bx_generate (width=bxv_width, depth=bxv_depth, height=bxv_height, thick=bxv_thick, wallrad=bxv_radius, botrad=bxv_radius, toprad=bxv_radius, lid=bxv_lid_height, lidtype=bxv_type, gap=bxv_lid_gap)
{
	assert(wallrad==0 || lidtype!=bxc_type_slide, "Box must have zero radius for a slide-on lid");
	assert(lid==0 || lidtype!=bxc_type_slide, "Box must have zero lid height for a slide-on lid");

	if (bxv_show_box) difference() {
		union() {
			bx_box(width,depth,height-lid-gap,thick,wallrad,botrad,lid,lidtype,gap);
			if (lidtype==bxc_type_snap) {
				bx_placeSnaps(width, depth, thick, height-lid-gap+bxc_snapVert);
			}
			bx_hook_boxAdds();
		}
		bx_hook_boxCuts();
	}
	if ((lid || lidtype==bxc_type_slide) && bxv_show_lid) bx_placeLid(height) bx_lid(width,depth,height,thick,wallrad,botrad,toprad,lid,lidtype,gap);
}

// hollowed out box shell
module bx_box (w, d, h, t, r, br, l, p, g=0)
{
	difference() {
		union() {
			color(bxc_bxColor) allRoundedCube(w,d,h,r,br);
			if (p==bxc_type_snap || p==bxc_type_cover) {
				assert(l >= t+bxc_ridgeH, str("The lid height must be at least ", t+bxc_ridgeH));
				color(bxc_bxColor) translate([t/2+bxc_clr,t/2+bxc_clr,h-.1]) allRoundedCube(w-t-bxc_clr*2,d-t-bxc_clr*2,bxc_ridgeH-.2,max(r-t/2,1),0);
			}
		}
		// interior of box
		translate([t,t,t]) bx_interior(w-t*2,d-t*2,h+bxc_ridgeH,max(r-t,1),max(br-t,0),0);
		if (p==bxc_type_slide) translate([t/2,t/2,h-t]) bx_slideShape(w-t/2+.01,d-t,t+.01,false);
	}
}

module bx_cornerCube (w, d, r, h)
{
	linear_extrude(h) hull() {
		translate([r,r]) circle(r);
		polygon([[0,w],[w,d],[d,0]]);
	};
}

module bx_lid (w, d, h, t, r, br, tr, l, p, g=0)
{
	if (p==bxc_type_slide) {
		translate([t/2+bxc_clr,t/2+bxc_clr,h-l]) bx_slideShape(w-t/2-bxc_clr,d-t-bxc_clr*2,t);
	} else {
	// top of lid
	translate([0,0,h-l])
		difference() {
			th2 = t*2;
			union() {
				allRoundedCube(w,d,l,r,0,tr);
				bx_hook_lidAdds();
			}
			if (l>t) translate([t,t,-.01])
				bx_interior(w-th2,d-th2,l-t+.01,max(r-t,1),0,0);	//#allRoundedCube(w-th2,d-th2,l-t,r-t,br-t,tr-t);
			if (p==bxc_type_snap || p==bxc_type_cover) {
				translate([t/2,t/2,-.01]) allRoundedCube(w-t,d-t,bxc_ridgeH+.01,r-t/2,0);
				if (p==bxc_type_snap) {
					bx_placeSnaps(w,d);
				}
			}
			bx_hook_lidCuts();
		}
	}

	// gap between lid and box
//	if (g) translate([0,0,h-l-g]) allRoundedCube(w,d,g,r,0,0,true);
	if (g) utl_distRectangle(w,d,0,0,0,h-l-g,true) bx_cornerCube(bxc_pegT+bxc_clr+t,bxc_pegT+bxc_clr+t,r,g);
	if (p==bxc_type_peg) {
		// peg risers if necessary
		if (l && (l+g)>t) bx_placeRisers(w,d,h,t,t,l) bx_sqrRiser(bxc_pegT+bxc_clr,l-t);
		// lid pegs
		pgr = max(r-t-bxc_clr, .5);
		color(bxc_pegColor) bx_placePegs(w,d,h-g,t,t,l) //#cube([2,2,bxc_pegH]);	//scube(w-t*2-bxc_clr*2,d-t*2-bxc_clr*2,t-bxc_clr,p);
			linear_extrude(bxc_pegH) translate([bxc_clr,bxc_clr]) hull() {
				translate([pgr,pgr]) circle(pgr);
				polygon([[0,bxc_pegT],[bxc_pegT,bxc_pegT],[bxc_pegT,0]]);
			};
	}
}

module bx_interior (width, depth, height, rad, bot, top)
{	echo(width, depth, height, rad, bot, top);
	st = 1.2;	// internal wall thickness
	nx = max(1,bxv_cols);
	ny = max(1,bxv_rows);
	dx = (width-(nx-1)*st)/nx;
	ox = dx+st;
	dy = (depth-(ny-1)*st)/ny;
	oy = dy+st;
	for (cx = [ 0 : nx - 1]) {
		for (cy = [ 0 : ny - 1]) {
			// normal cutout
			translate([ox*cx,oy*cy]) allRoundedCube(dx,dy,height,rad,bot,top);
			// extend for any excluded walls
			translate([ox*cx,oy*cy]) union() {
				if (cx<nx-1) for (ix = bxv_no_row_wall) {
					if (cx==ix[0] && cy==ix[1]) {
						allRoundedCube(dx*2,dy,height,rad,bot,bot);
					}
				}
				if (cy<ny-1) for (ix = bxv_no_col_wall) {
					if (cx==ix[0] && cy==ix[1]) {
						allRoundedCube(dx,dy*2,height,rad,bot,bot);
					}
				}
			}
		}
	}
}

module bx_snapNub (l,r)
{
	difference() {
		utl_mirror([0,0,1]) cylinder(l/2,r,r/2);
		translate([0,r,0]) cube([r*2,r*2,l+.1],true);
	}
}

module bx_placeSnaps (w, d, t=0, h=0)
{
	sw = 10;		// snap width
	sd = 1.8;		// snap nub diameter

	if (t) {
		// add snap nubs
		sl = sw-2;;
		sr = sd/2;
		if (w>d) {
			_w = w/2;
			d1 = t/2+bxc_clr*2;
			d2 = d-t/2-bxc_clr*2;
			color(bxc_snapColor) translate([_w,d1,h]) rotate([0,90]) bx_snapNub(sl,sr);
			color(bxc_snapColor) translate([_w,d2,h]) rotate([0,90,180]) bx_snapNub(sl,sr);
		} else {
			w1 = t/2+bxc_clr*2;
			w2 = w-t/2-bxc_clr*2;
			_d = d/2;
			color(bxc_snapColor) translate([w1,_d,h]) rotate([90,90]) bx_snapNub(sl,sr);
			color(bxc_snapColor) translate([w2,_d,h]) rotate([90,270]) bx_snapNub(sl,sr);
		}
	} else {
		// subtract snap receptor
		sh = bxc_snapVert;
		if (w>d) {
			_w = w/2;
			d1 = sd-.2;
			d2 = d-sd+.2;
			sy = sd*2;
			translate([_w,d1,sh]) cube([sw,sy,sd],true);
			translate([_w,d2,sh]) cube([sw,sy,sd],true);
		} else {
			w1 = sd-.2;
			w2 = w-sd+.2;
			_d = d/2;
			sx = sd*2;
			translate([w1,_d,sh]) cube([sx,sw,sd],true);
			translate([w2,_d,sh]) cube([sx,sw,sd],true);
		}
	}
}

module bx_slideShape (w, d, h, thm=true)
{
	h2 = h/2;
	difference() {
		polyhedron (
			[[0,0,0],[w,0,0],[w,d,0],[0,d,0],[h2,h2,h],[w,h2,h],[w,d-h2,h],[h2,d-h2,h]],
			[[0,1,2,3],[4,5,1,0],[7,6,5,4],[5,6,2,1],[6,7,3,2],[7,4,0,3]]
		);
		// optionally, gouge out a thumb catch
		if (thm) translate([w-3,d/2,11.4]) rotate([0,-90,0]) cylinder(10,10,6);
	}
}

module bx_sqrRiser (rzd, rzh)
{
	hull() {
		cube([rzd,rzd,.01]);
		if (rzh > rzd*2) {
			translate([0,0,rzh]) cube([.01,.01,.01]);
		} else {
			translate([0,0,rzh]) cube([rzd,rzd,.01]);
		}
	}
}

module bx_placeRisers (w, d, h, t, r, l)
{
	rz = h-l;
	utl_distRectangle(w,d,r,r,r,rz,true) children();
}

module bx_placePegs (w, d, h, t, r, l)
{
	rz = h-l-bxc_pegH;
	utl_distRectangle(w,d,r,r,r,rz,true) children();
}

module bx_placeLid (h)
{
	if (is_undef(bxv_lid_on_box) || !bxv_lid_on_box) {
		if (bxv_type==bxc_type_slide) {
			translate([0,-bxv_depth-5,-h]) children();
		} else {
			rotate([180,0,0]) translate([0,5,-h]) children();
		}
	} else {
		translate([0,0,bxv_type==bxc_type_slide?-bxv_thick+.01:0]) children();
	}
}


// ==================================== hooks for cutouts and additions
module bx_hook_boxCuts ()
{
}
module bx_hook_boxAdds ()
{
}
module bx_hook_lidCuts ()
{
}
module bx_hook_lidAdds ()
{
}

// ==================================== actions to cutout simple shapes from sides and top
module bx_cutLeft (deep=0, d3=false)
{
	if (deep==0) {
		children();
	} else {
		y = deep ? deep : bxv_thick+.01;
		translate([0,y,0]) rotate([90,0,0]) linear_extrude(bxv_thick+.02) children();
	}
}
module bx_cutRight (deep=0)
{
	if (deep==0) {
		translate([bxv_width,bxv_depth,0]) rotate([0,0,180]) children();
	} else {
		y = deep ? deep : bxv_thick+.01;
		translate([bxv_width,bxv_depth-y,0]) rotate([90,0,180]) linear_extrude(bxv_thick+.02) children();
	}
}
module bx_cutBack (deep=0)
{
	if (deep==0) {
		translate([0,bxv_depth,0]) rotate([0,0,-90]) children();
	} else {
		x = deep ? deep : bxv_thick+.01;
		translate([x,bxv_depth,0]) rotate([90,0,-90]) linear_extrude(bxv_thick+.02) children();
	}
}
module bx_cutFront (deep=0)
{
	if (deep==0) {
		translate([bxv_width,0,0]) rotate([0,0,90]) children();
	} else {
		x = deep ? deep : bxv_thick+.01;
		translate([bxv_width-x,0,0]) rotate([90,0,90]) linear_extrude(bxv_thick+.02) children();
	}
}
module bx_cut (deep=0)
{
	y = deep ? deep : bxv_thick+.01;
	translate([0,0,bxv_lid_height-y]) linear_extrude(y) children();
}

// ==================================== actions to add simple shapes to sides
module bx_addLeft (offs=0)
{
	y = offs ? offs : bxv_thick+.01;
	translate([0,y,0]) rotate([90,0,0]) linear_extrude(bxv_thick+.02) children();
}
module bx_addRight (offs=0)
{
	y = offs ? offs : bxv_thick+.01;
	translate([bxv_width,bxv_depth-y,0]) rotate([90,0,180]) linear_extrude(bxv_thick+.02) children();
}
module bx_addBack (offs=0)
{
	x = offs ? offs : bxv_thick+.01;
	translate([x,bxv_depth,0]) rotate([90,0,-90]) linear_extrude(bxv_thick+.02) children();
}
module bx_addFront (offs=0)
{
	x = offs ? offs : bxv_thick+.01;
	translate([bxv_width-x,0,0]) rotate([90,0,90]) linear_extrude(bxv_thick+.02) children();
}



