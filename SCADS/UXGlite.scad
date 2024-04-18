$fn = $preview ? 6 : 120;

in_w = 104;
in_d = 27;
in_h = 130;
wall = 2;
ex_w = in_w + wall*2;
ex_d = in_d + wall*2;
ex_h = in_h + wall*2;
bak_in = wall + 6;
bot_off = 20;   //ex_w/5;
cb_w = 20;
screw = 6;

module bridge () {
    hull() {
        translate([0,0,in_d+2]) cube([wall+1,1,1]);
        translate([0,ex_h/2,in_d+2]) cube([wall+1,1,1]);
        translate([0,ex_h/2]) cube([wall+1,1,1]);
    }
}

module cross_bar () {
    cube([ex_w+wall*2, cb_w, wall]);
    translate([0,0,wall]) cube([wall,cb_w,wall]);
    translate([ex_w+wall,0,wall]) cube([wall,cb_w,wall]);
}

difference() {
    cube([ex_w, ex_h, ex_d]);
    translate([wall,wall,wall]) cube([in_w, in_h+wall+1, in_d+wall+1]);
    // bridges
    translate([-.1,ex_h/2,wall]) bridge();
    translate([in_w+1.4,ex_h/2,wall]) bridge();
    // open bottom
    translate([bot_off,-.1,wall]) cube([ex_w-bot_off*2, wall+1, in_d+wall+1]);
    // open back
    translate([bak_in,bak_in,-.1]) cube([ex_w-bak_in*2, ex_w-bak_in*2, wall+1]);
    // screw holes
    translate([bot_off,in_w+16,-.1]) cylinder(wall+1, d=screw);
    translate([ex_w-bot_off,in_w+16,-.1]) cylinder(wall+1, d=screw);
}

translate([-wall,-cb_w-2,0]) cross_bar();