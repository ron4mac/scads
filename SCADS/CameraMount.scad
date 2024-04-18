
m_w = 40;
m_h = 20;
m_h2 = 20;
m_thk = 5;

nut_d = 6.6;
nut_t = 2.8;
hole_d = 3.2;

module _A () {
    cube([m_w,m_h,m_thk]);
    translate([0,m_h,0]) cube([m_w,m_h2,m_thk-1.3]);
}

module _B () {
    difference() {
        //cube([m_w,m_h+m_h2,m_thk]);
        _A();
        translate([m_w/4,m_h+m_h2/2,1]) cylinder(nut_t, d=nut_d, $fn=6);
        translate([m_w-m_w/4,m_h+m_h2/2,1]) cylinder(nut_t, d=nut_d, $fn=6);
        translate([m_w/4,m_h+m_h2/2,-.1]) cylinder(m_thk, d=hole_d, $fn=60);
        translate([m_w-m_w/4,m_h+m_h2/2,-.1]) cylinder(m_thk, d=hole_d, $fn=60);
    }
}

//_A();
//translate([m_w+5,0,0]) _B();
_B();