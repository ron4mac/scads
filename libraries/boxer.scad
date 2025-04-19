assert(!is_undef(width), "Must have 'width' defined (number)");
assert(!is_undef(depth), "Must have 'depth' defined (number)");
assert(!is_undef(height), "Must have 'height' defined (number)");

_bxThk = is_undef(wall) ? 1.2 : wall;
_bxThkIn = is_undef(inwall) ? _bxThk : inwall;
_bxIn = is_undef(inside) ? false : inside;
_bxW = _bxIn ? width+_bxThk*2 : width;
_bxD = _bxIn ? depth+_bxThk*2 : depth;
_bxH = _bxIn ? height+_bxThk : height;
_bxR = is_undef(rad) ? 1 : rad;
_bxColumns = is_undef(columns) ? 1 : columns;
_bxRows = is_undef(rows) ? 1 : rows;
_bxBlocks = is_undef(blocks) ? [] : blocks;


echo(_bxColumns,_bxRows);

module tshape (s,r)
{
	if (s) { sphere(r); }
	else { cylinder(r*2,r,r,true);}
}

// create a cube object with rounding
module _bxCube (W,D,R,b=false,t=false)
{
	let(r = R>0?R:.01, w = (W-r*2)/2, d = (D-r*2)/2, h = _bxH/2-r)
	hull () {
	//union () {
		translate([w,d,h]) tshape(t,r);
		translate([w,-d,h]) tshape(t,r);
		translate([-w,d,h]) tshape(t,r);
		translate([-w,-d,h]) tshape(t,r);
		translate([w,d,-h]) tshape(b,r);
		translate([w,-d,-h]) tshape(b,r);
		translate([-w,d,-h]) tshape(b,r);
		translate([-w,-d,-h]) tshape(b,r);
	}
}

// build what will be carved from the interior
module _bxInterior ()
{
	//translate([0,0,_bxThk]) _bxCube(_bxW-_bxThk*2,_bxD-_bxThk*2,_bxR-_bxThk,false);
	let(
		W = _bxW-_bxThk*2,
		D = _bxD-_bxThk*2,
		dx = (W-(_bxColumns-1)*_bxThkIn)/_bxColumns,
		ox = dx+_bxThkIn,
		dy = (D-(_bxRows-1)*_bxThkIn)/_bxRows,
		oy = dy+_bxThkIn,
		tox = _bxColumns>1 ? W/2-dx/2 : 0,
		toy = _bxRows>1 ? D/2-dy/2 : 0
	) union() {
		for (cx = [ 0 : _bxColumns - 1]) {
			for (cy = [ 0 : _bxRows - 1]) {
				// normal cutout
				translate([ox*cx-tox,oy*cy-toy,0])
					_bxCube(dx,dy,_bxR-_bxThk);
			}
		}
		// remove any multi-width blocks
		for (blk = _bxBlocks) {
			blkw = ox*blk[2]-_bxThkIn;
			blkh = oy*blk[3]-_bxThkIn;
			translate([ox*(blk[0]-(_bxColumns-blk[2])/2),oy*(blk[1]-(_bxRows-blk[3])/2),0])
				_bxCube(blkw,blkh,_bxR-_bxThk);
				//allRoundedCube(blkw,blkh,height,rad,bot,top);
		}
	}
}

// create a box by removing an interior structure from a solid object
module _cbx ()
{
	difference() {
		union () {
			_bxCube(_bxW,_bxD,_bxR,false);
			bxHookBoxAdds();
		}
		translate([0,0,_bxThk])
			_bxInterior();
		bxHookBoxCuts();
	}
}

module cbx (centered=true)
{
	if (centered) {
		_cbx();
	} else {
		translate([_bxW/2,_bxD/2,_bxH/2]) _cbx();
	}
}

// ==================================== hooks for cutouts and additions
module bxHookBoxCuts ()
{
}
module bxHookBoxAdds ()
{
}
module bxHookLidCuts ()
{
}
module bxHookLidAdds ()
{
}

// ==================================== actions to cutout simple shapes from sides and top
module bxCutLeft (deep=0, d3=false)
{
	if (deep==0) {
		translate([-_bxW/2,-_bxD/2,0]) rotate([0,0,0]) children();
	} else {
		y = deep ? deep : _bxThk+.01;
		translate([0,_bxThk-_bxD/2,0]) rotate([90,0,0]) linear_extrude(_bxThk+.02) children();
	}
}
module bxCutRight (deep=0)
{
	if (deep==0) {
		translate([_bxW/2,_bxD/2,0]) rotate([0,0,180]) children();
	} else {
		y = deep ? deep : _bxThk+.01;
		translate([0,_bxD/2-_bxThk,0]) rotate([90,0,180]) linear_extrude(_bxThk+.02) children();
	}
}
module bxCutBack (deep=0)
{
	if (deep==0) {
		translate([-_bxW/2,0,0]) rotate([0,0,-90]) children();
	} else {
		x = deep ? deep : _bxThk+.01;
		translate([-_bxW/2+x,0,0])
			rotate([90,0,-90])
				linear_extrude(_bxThk+.02) children();
	}
}
module bxCutFront (deep=0)
{
	if (deep==0) {
		translate([_bxW/2,0,0]) rotate([0,0,90]) children();
	} else {
		x = deep ? deep : _bxThk+.01;
		translate([_bxW/2-x,0,0])
			rotate([90,0,90])
				linear_extrude(_bxThk+.02) children();
	}
}
module bxCut (deep=0)
{
	y = deep ? deep : _bxThk+.01;
	translate([0,0,bxv_lid_height-y]) linear_extrude(y) children();
}

// ==================================== actions to add simple shapes to sides
module bxAddLeft (offs=0)
{
	//y = offs ? offs : _bxThk+.01;
	translate([0,-_bxD/2-offs,0]) rotate([90,0,0]) linear_extrude(_bxThk+.02) children();
}
module bxAddRight (offs=0)
{
	//y = offs ? offs : _bxThk+.01;
	translate([0,_bxD/2-offs,0]) rotate([90,0,180]) linear_extrude(_bxThk+.02) children();
}
module bxAddBack (offs=0)
{
	//x = offs ? offs : _bxThk+.01;
	translate([-_bxW/2+offs,0,0]) rotate([90,0,-90]) linear_extrude(_bxThk+.02) children();
}
module bxAddFront (offs=0)
{
	//x = offs ? offs : _bxThk+.01;
	translate([_bxW/2-offs,0,0]) rotate([90,0,90]) linear_extrude(_bxThk+.02) children();
}

