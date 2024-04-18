// Razor scraper

w=40;// width of razor
l=11.5;// length to stops
t=1;// thickness of razor
d=2.7;// diameter of stops
w1=4;// width of stops

difference(){
	union(){
		translate([0,-l/2-3,3/2])cube([w+6,l+6,3],center=true);
		translate([0,-l-6,1.5])scale([1,0.5,1])rotate([0,0,45])
			cube([(w+6)/sqrt(2),(w+6)/sqrt(2),3],center=true);
		translate([-5,-90,0])cube([10,80,6]);
	}
	difference(){
		translate([0,0,t/2+1])cube([w,2*l,t],center=true);
		translate([w/2-w1+d/2,-d/2,0])cylinder(r=d/2,h=3*t,$fn=12);
		translate([w/2-w1+d/2,-d,0])cube([2*w1,d,3*t]);
		translate([-(w/2-w1+d/2),-d/2,0])cylinder(r=d/2,h=3*t,$fn=12);
		translate([-w/2-w1-d/2,-d,0])cube([2*w1,d,3*t]);
	}
	translate([0,-15,2-0.01])scale([1,0.5,1])rotate([0,0,45])cube(2*w);
	translate([0,-8,-0.01])scale([1,0.5,1])rotate([0,0,45])cube(2*w);
	translate([-w,-3,2.5])rotate([83,0,0])cube(2*w);
}