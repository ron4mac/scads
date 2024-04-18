use <rounded.scad>


// lid types
cover_type = 0;
snap_type = 1;
slide_type = 2;
peg_type = 3;

// box dimensions
bx_width = 80;
bx_depth = 60;
bx_height = 30;
bx_thick = 2.4;
bx_lid_height = 8;

// the type of box to generate
bx_type = cover_type;
// box exterior edge radius
bx_radius = 3;

// box rows and columns
bx_cols = 1;
bx_rows = 1;
bx_no_col_wall = [];
bx_no_row_wall = [];

// show box parts
bx_show_box = true;
bx_show_lid = true;

// internal constants
pclr = .16;	// parts clearance
_pegH = 3;	// lid peg height
_pegT = 4;	// lid peh thickness

module xx_box (width, depth, height, thick, lid=0, lidtype=bx_type, gap=0)
{
	difference() {
		th2 = thick*2;
		cube([width,depth,height-lid-gap]);
		translate([thick,thick,thick])
			cube([width-th2,depth-th2,height-thick-lid-gap+.01]);
	}
	if (lid) placeLid(height) boxLid(width,depth,height,thick,lid,lidtype,gap);
}

module xx_boxLid (w, d, h, t, l, p, g)
{
	translate([0,0,h-l]) difference() {
		th2 = t*2;
		cube([w,d,l]);
		if (l>t) translate([t,t,-.01])
			cube([w-th2,d-th2,l-t+.01]);
	}
	// gap between lid and box
	if (g) translate([0,0,h-l-g]) scube(w,d,t*2,g);
	// peg risers if necessary
	if (l && l>t) placeRisers(w,d,h,t,t,l) sqrRiser(t,l-t);
	// lid pegs
	translate([t+pclr,t+pclr,h-l-p-g]) scube(w-t*2-pclr*2,d-t*2-pclr*2,t-pclr,p);
}

module roundedBox (width=bx_width, depth=bx_depth, height=bx_height, thick=bx_thick, wallrad=bx_radius, botrad=bx_radius, toprad=bx_radius, lid=bx_lid_height, lidtype=bx_type, gap=0)
{
	assert(wallrad==0 || lidtype!=slide_type, "Box must have zero radius for a slide-on lid");
	assert(lid==0 || lidtype!=slide_type, "Box must have zero lid height for a slide-on lid");

	colr = "BurlyWood";
	if (bx_show_box) difference() {
		union() {
			color(colr) allRoundedCube(width,depth,height-lid-gap,wallrad,botrad);
			if (lidtype==snap_type || lidtype==cover_type) {
				assert(lid >= thick+5, str("The lid height must be at least ", thick+5));
				color(colr) translate([thick/2+pclr,thick/2+pclr,height-lid-gap/*-.2*/]) allRoundedCube(width-thick-pclr*2,depth-thick-pclr*2,4.8,wallrad-thick/2,0);
				if (lidtype==snap_type) {
					placeSnaps(width, depth, thick, height-lid-gap+3);
				}
			}
		}
		// interior of box
//		translate([thick,thick,thick]) allRoundedCube(width-thick*2,depth-thick*2,height/*-thick-lid-gap+.01*/,wallrad-thick,botrad);

		translate([thick,thick,thick]) roundedInterior(width-thick*2,depth-thick*2,height-lid+6,max(wallrad-thick,1),max(botrad-thick,1));
		if (lidtype==slide_type) translate([thick/2,thick/2,height-thick]) slideShape(width-thick/2+.01,depth-thick,thick+.01,false);

	//	if (lidtype==snap_type) {
	//		translate([thick/2,thick/2,height-lid-gap-5]) allRoundedCube(width-thick,depth-thick,5,wallrad-thick/2,0);
	//	}
	}
	if ((lid || lidtype==slide_type) && bx_show_lid) placeLid(height) roundedBoxLid(width,depth,height,thick,wallrad,botrad,toprad,lid,lidtype,gap);
}

module roundedBoxLid (w, d, h, t, r, br, tr, l, p, g=0)
{
	if (p==slide_type) {
		translate([t/2+pclr,t/2+pclr,h-l]) slideShape(w-t/2-pclr,d-t-pclr*2,t);
	} else {
	// top of lid
	translate([0,0,h-l]) difference() {
		th2 = t*2;
		allRoundedCube(w,d,l,r,0,tr);
		if (l>t) translate([t,t,-.01])
			roundedInterior(w-th2,d-th2,l-t+.01,max(r-t,1),0,0);	//#allRoundedCube(w-th2,d-th2,l-t,r-t,br-t,tr-t);
		if (p==snap_type || p==cover_type) {
			translate([t/2,t/2,-.01]) allRoundedCube(w-t,d-t,5.01,r-t/2,0);
			if (p==snap_type) {
				placeSnaps(w,d);
			}
		}
	}
	}

	// gap between lid and box
	if (g) translate([0,0,h-l-g]) allRoundedCube(w,d,g,r,0,0,true);
	if (p==peg_type) {
		// peg risers if necessary
	//	if (l && l>t) placeRisers(w,d,h,t,r,l) rndRiser(g?r:r-t,l-t);
		if (l && l>t) placeRisers(w,d,h,t,t,l) sqrRiser(_pegT+pclr,l-t);
		// lid pegs
	//	translate([t+pclr,t+pclr,h-t-l-g-1]) allRoundedCube(w-t*2-pclr*2,d-t*2-pclr*2,t+1,r-t-pclr,0,0,true);
		pgr = max(r-t-pclr, .5);
		color("Coral") placePegs(w,d,h,t,t,l) //#cube([2,2,_pegH]);	//scube(w-t*2-pclr*2,d-t*2-pclr*2,t-pclr,p);
			linear_extrude(_pegH) translate([pclr,pclr]) hull() {
				translate([pgr,pgr]) circle(pgr);
				polygon([[0,_pegT],[_pegT,_pegT],[_pegT,0]]);
			};
	}
}

module roundedInterior (width, depth, height, rad, bot, top)
{
	st = 1.2;	// internal wall thickness
	nx = max(1,bx_cols);
	ny = max(1,bx_rows);
	dx = (width-(nx-1)*st)/nx;
	ox = dx+st;
	dy = (depth-(ny-1)*st)/ny;
	oy = dy+st;
	for (cx = [ 0 : nx - 1]) {
		for (cy = [ 0 : ny - 1]) {
			// normal cutout
			translate([ox*cx,oy*cy]) allRoundedCube(dx,dy,height,rad,bot,bot);
			// extend for any excluded walls
			translate([ox*cx,oy*cy]) union() {
				if (cx<nx-1) for (ix = bx_no_row_wall) {
					if (cx==ix[0] && cy==ix[1]) {
						allRoundedCube(dx*2,dy,height,rad,bot,bot);
					}
				}
				if (cy<ny-1) for (ix = bx_no_col_wall) {
					if (cx==ix[0] && cy==ix[1]) {
						allRoundedCube(dx,dy*2,height,rad,bot,bot);
					}
				}
			}
		}
	}

	//allRoundedCube(width,depth,height,rad-thick,bot);
}

module placeSnaps (w, d, t=0, h=0)
{
	sw = 10;	// snap width
	sd = 1.8;	// snap nub diameter

	if (t) {
		// add snap nubs
		//sh = height-lid-gap+3;
		sl = sw-4;;
		sr = sd/2;	//.9;
		if (w>d) {
			_w = w/2;
			d1 = t/2+pclr*2;
			d2 = d-t/2-pclr*2;
			color("Coral") translate([_w,d1,h]) rotate([0,90]) cylinder(sl,sr,sr,true);
			color("Coral") translate([_w,d2,h]) rotate([0,90]) cylinder(sl,sr,sr,true);
		} else {
			w1 = t/2+pclr*2;
			w2 = w-t/2-pclr*2;
			_d = d/2;
			color("Coral") translate([w1,_d,h]) rotate([90,0]) cylinder(sl,sr,sr,true);
			color("Coral") translate([w2,_d,h]) rotate([90,0]) cylinder(sl,sr,sr,true);
		}
	} else {
		// subtract snap receptor
		sh = 3;
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

module slideShape (w, d, h, thm=true)
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

module sqrRiser (rzd, rzh)
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

module xx_rndRiser (rzr, rzh)
{
	hull() {
		cylinder(.01,rzr,rzr);
		if (rzh > rzr*2) {
			zo = sqrt(rzr^2*2)/2-.1;	//min(rzr/1.3,1);
			translate([-zo,-zo,rzh]) cylinder(.01,.01,.01);
		} else {
			translate([0,0,rzh]) cylinder(.01,rzr,rzr);
		}
	}
}

module placeRisers (w, d, h, t, r, l)
{
	rz = h-l;
	translate([r,r,rz]) children();
	translate([r,d-r,rz]) rotate([0,0,270]) children();
	translate([w-r,d-r,rz]) rotate([0,0,180]) children();
	translate([w-r,r,rz]) rotate([0,0,90]) children();
}

module placePegs (w, d, h, t, r, l)
{
	rz = h-l-_pegH;
	translate([r,r,rz]) children();
	translate([r,d-r,rz]) rotate([0,0,270]) children();
	translate([w-r,d-r,rz]) rotate([0,0,180]) children();
	translate([w-r,r,rz]) rotate([0,0,90]) children();
}

module placeLid (h)
{
	if (is_undef(bx_lid_on_box) || !bx_lid_on_box) {
		if (bx_type==slide_type) {
			translate([0,-bx_depth-5,-h]) children();
		} else {
			rotate([180,0,0]) translate([0,5,-h]) children();
		}
	} else {
		translate([0,0,bx_type==slide_type?-bx_thick+.01:0]) children();
	}
}

