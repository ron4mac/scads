use <utils.scad>

module rpi_mount_posts (h=6, w=58, d=49, sub=false) {
	if (sub) {
		translate([0,0,-3]) union() {
			utl__distRectangle(w, d, 0) cylinder(h+6, 1.65, 1.65);
			if (sub==2) utl__distRectangle(w, d, 0) cylinder(2.4, 3, 3);
		}
	} else {
		difference() {
			utl__distRectangle(w, d, 0) rpi_post(h);
			translate([0,0,-3]) utl__distRectangle(w, d, 0) cylinder(h+6, 1.65, 1.65);
		}
	}
}

module rpi_zero_io (thk) {
	margin = 2.2;
	m2 = margin*2;
	translate([6.5,0,0]) cube([12,4.6,thk]);
	translate([37.1,0,0]) cube([8.5,3.6,thk]);
	translate([49.9,0,0]) cube([8.5,3.6,thk]);
	translate([6.5-margin,0-margin,thk/2]) cube([12+m2,4.6+m2,thk/2]);
	translate([37.1-margin,0-margin,thk/2]) cube([8.5+m2,3.6+m2,thk/2]);
	translate([49.9-margin,0-margin,thk/2]) cube([8.5+m2,3.6+m2,thk/2]);
}

module rpi_vent (w, d, h, v=true) {
	utl_distLinear (w/4, [w,0,0]) cube([2,d,h]);
}

module rpi_post (h) {
	cylinder(h-1.4, 4, 4);
	cylinder(h, 2.9, 2.9);
	cylinder(1, 5, 4);
}

module WS_CM4_IO () {
	cube([16,8,2]);
	translate([18.8,0,0]) cube([15.6,18,2]);
	translate([35.9,0,0]) cube([17.5,15.5,2]);
}
module WS_CM4_PWR () {
	cube([13,6,2]);
}

module rpi_fan_40mm (wall) {
	difference() {
		cylinder(wall+.2, 19.6, 19.6);
		#fanVanes(wall);
	}
	translate([-16,-16,0]) utl_distRectangle(32, 32, 0) cylinder(wall+.2, 2.2, 3);
}

module fanHoles () {
	cylinder(wall+.2, 19.6, 19.6);
	translate([-16,-16,0]) utl_distRectangle(32, 32, 0) cylinder(wall+.2, 2.2, 3);
}

module fanVanes (wall)
{
    for (_d=[0:30:330]) /*translate([0,0,-wall])*/ fanVane(wall,_d);
}
module fanVane (wall,deg)
{
    rotate([0,0,deg]) translate([6,-.6,0]) rotate([0,0,-110]) cube([21,1.2,wall]);
}
