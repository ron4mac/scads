$fn=500;
$dd=31;
linear_extrude(height=0.8){
    difference(){
        union(){
            difference(){
                union(){
                    circle(d=160);
                    square(size=80, center=false);
                }
                circle(d=140);
                translate([55, 55, 0]){
                    #square(size=20, center=false);
                }
            }    
            translate([cos(45)*$dd, 0, 0]){
                #square([10,140], center=true);
            }
            translate([-cos(45)*$dd, 0, 0]){
                square([10,140], center=true);
            }
            translate([0, cos(45)*$dd, 0]){
                square([140,10], center=true);
            }
            translate([0, -cos(45)*$dd, 0]){
                square([140,10], center=true);
            }
        }
    #translate([cos(45)*$dd, cos(45)*$dd, 0]){
        circle(d=4);
        }
    #translate([-cos(45)*$dd, cos(45)*$dd, 0]){
        circle(d=4);
        }
    #translate([-cos(45)*$dd, -cos(45)*$dd, 0]){
        circle(d=4);
        }
    #translate([cos(45)*$dd, -cos(45)*$dd, 0]){
        circle(d=4);
        }
    #translate([-cos(45)*$dd, -cos(45)*$dd, 0]){
        rotate([0,0,45]) square([62,6], center=false);
        }
/*    //further reduce printing the outer arcs
    translate([0, -cos(45)*31-40, 0]){
        square([200, 70], center=true);
        }
    translate([-cos(45)*31-40, 0,  0]){
        square([70, 200], center=true);
        }
*/
    }
}