
width = 100;
depth = 50;
height = 50;
wall = 1.2;
rad = 6;
mldw = width-rad*2;
mldd = depth-rad*2;

module bottom(W,D,R)
{
    minkowski() {
        cube([W,D,height], center=true);
        cylinder(r=R,h=wall, center=true, $fn=60);
    }
}

difference() {
    bottom(mldw,mldd,rad);
    translate([0,0,wall])bottom(mldw,mldd,rad-wall*2);
}
