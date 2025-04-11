/*
This YAPP_generator sample is for a raspberry pi 4b case
It accommodates a 40mm x 10mm 5V fan attached to the lid
Specific fan used was a Noctua NF-A4x10 attached with M2 6mm truss head wood screws
PCB standoffs are for a typical M2.5 6mm standoff screw
*/
include <YAPPgenerator_v3.scad>

printBaseShell      = true;
printLidShell       = true;

//-- pcb dimensions -- very important!!!
// Electro cookie 30 row
pcbLength           = 85; // Front to back
pcbWidth            = 56; // Side to side
pcbThickness        = 1.5;
                            
//-- padding between pcb and inside wall
paddingFront        = 0.4;
paddingBack         = 3.6;
paddingRight        = 1;
paddingLeft         = 0.2;

//-- Edit these parameters for your own box dimensions
wallThickness       = 2.0;
basePlaneThickness  = 1.6;
lidPlaneThickness   = 1.6;

//-- Total height of box = lidPlaneThickness 
//                       + lidWallHeight 
//--                     + baseWallHeight 
//                       + basePlaneThickness
//-- space between pcb and lidPlane :=
//--      (bottonWallHeight+lidWallHeight) - (standoffHeight+pcbThickness)
baseWallHeight      = pcbThickness + 9;
lidWallHeight       = 22;

//-- ridge where base and lid off box can overlap
//-- Make sure this isn't less than lidWallHeight
ridgeHeight         = 3.8;
ridgeSlack          = 0.3;
roundRadius         = 1.0;

//-- How much the PCB needs to be raised from the base
//-- to leave room for solderings and whatnot
standoffHeight      = 5.8;
standoffPinDiameter = 2.5;
standoffHoleSlack   = 0;
standoffDiameter    = 6.0;

//-- C O N T R O L -------------//-> Default ---------
showSideBySide      = true;     //-> true
previewQuality      = 5;        //-> from 1 to 32, Default = 5
renderQuality       = 24;       //-> from 1 to 32, Default = 8
onLidGap            = 0;
shiftLid            = 5;
colorLid            = "YellowGreen";   
alphaLid            = 1;//0.25;   
colorBase           = "BurlyWood";
alphaBase           = 1;//0.25;
hideLidWalls        = false;    //-> false
hideBaseWalls       = false;    //-> false
showOrientation     = false;
showPCB             = false;
showSwitches        = false;
showPCBmarkers      = false;
showShellZero       = false;
showCenterMarkers   = false;
inspectX            = 0;        //-> 0=none (>0 from back)
inspectY            = 0;        //-> 0=none (>0 from right)
inspectXfromBack    = false;    // View from the inspection cut foreward
inspectYfromLeft    = false;    // View from the inspection cut to the right
inspectZfromTop     = false;
//-- C O N T R O L ---------------------------------------

pcbStands = [
    [3.5, 3.5, yappHole, yappBaseOnly, yappNoFillet],
    [3.5, 49+3.5, yappHole, yappBaseOnly, yappNoFillet],
    [58+3.5, 3.5, yappHole, yappBaseOnly, yappNoFillet],
    [58+3.5, 49+3.5, yappHole, yappBaseOnly, yappNoFillet]
];

snapJoins = [
    [shellWidth/2, 8, yappBack, yappCenter],
    [shellLength-19, 8, yappLeft, yappRight, yappCenter]
];

//-- C U T O U T S ---------------------------------------
// left cutout
cutoutsLeft = [
    //[4.5,-.8,55,11,0,yappRectangle,wallThickness/2+.07],     //inset
    [11.2,pcbThickness+1.8,9.4,3.9,0,yappRectangle,yappCenter],     //power
    [25.8,pcbThickness+1.9,7.6,4.1,0,yappRectangle,yappCenter],           //dsp1
    [39.2,pcbThickness+1.9,7.6,4.1,0,yappRectangle,yappCenter],         //dsp2
    //[54,pcbThickness+3.5,7,7.4,0,yappRectangle,yappCenter]            //audio
];
// front cutouts
cutoutsFront = [
    [47,pcbThickness+8,15,16.3,0,yappRectangle,yappCenter],        //usb1
    [29.1,pcbThickness+8,15,16.3,0,yappRectangle,yappCenter],       //usb2
    [10.2,pcbThickness+6.8,16.4,13.9,0,yappRectangle,yappCenter]   //ethernet
];

cutoutsLid = [
    // Cutouts for fan
    [46,shellWidth/2,0,7.2,19.6,yappRing,yappCenter,yappCoordBox],
    //[46-16,shellWidth/2-16,4,0,3,yappCircle,yappCenter,yappCoordBox],
    //[46-16,shellWidth/2+16,4,0,3,yappCircle,yappCenter,yappCoordBox],
    //[46+16,shellWidth/2-16,4,0,3,yappCircle,yappCenter,yappCoordBox],
    //[46+16,shellWidth/2+16,4,0,3,yappCircle,yappCenter,yappCoordBox]
];

cutoutsBack = [
    // Cutout for vent
    [shellWidth/2,lidWallHeight+5,3,9,0,yappRectangle,yappCenter,yappCoordBox],
    [shellWidth/2-7,lidWallHeight+5,3,9,0,yappRectangle,yappCenter,yappCoordBox],
    [shellWidth/2+7,lidWallHeight+5,3,9,0,yappRectangle,yappCenter,yappCoordBox],
    [shellWidth/2-14,lidWallHeight+5,3,9,0,yappRectangle,yappCenter,yappCoordBox],
    [shellWidth/2+14,lidWallHeight+5,3,9,0,yappRectangle,yappCenter,yappCoordBox],
    [shellWidth/2-21,lidWallHeight+5,3,9,0,yappRectangle,yappCenter,yappCoordBox],
    [shellWidth/2+21,lidWallHeight+5,3,9,0,yappRectangle,yappCenter,yappCoordBox],
    [wallThickness+18.4,lidWallHeight-10.3,3,9,1.5,yappCircle,yappCenter,yappCoordBox]
];

// the printed circuit board
module pcb (xyz) {
    translate(xyz) difference() {
        color("Cyan", 0.3) linear_extrude(pcbThickness) hull () {
            circle(3.5);
            translate([0,49,0]) circle(3.5);
            translate([78,49,0]) circle(3.5);
            translate([78,0,0]) circle(3.5);
        }
        cylinder(2,1);
        translate([0,49,0]) cylinder(2,1);
        translate([58,49,0]) cylinder(2,1);
        translate([58,0,0]) cylinder(2,1);
    }
}
//-- modules used by hooks
module brdSupports (ys)
{
    _x = shellLength-wallThickness*2-3;
    for (y = ys) translate([_x,y]) cube([3,1.6,standoffHeight]);
}
module fanMounts (xys)
{
    _h = 8;
    _x = 46-wallThickness;
    _y = shellWidth/2-wallThickness;
    for (xy = xys) {
        translate([_x+xy[0],_y+xy[1],-2]) cylinder(3,2.5,2.5);
        translate([_x+xy[0],_y+xy[1],-_h]) difference() {
            cylinder(_h,2,2);
            translate([0,0,-_h/2]) cylinder(_h,1,1);
        }
    }
}
module fanVane (deg)
{
    rotate([0,0,deg]) translate([6,-.6,0]) rotate([0,0,-110]) cube([21,1.2,lidPlaneThickness]);
}
module fanVanes ()
{
    // fan vanes (have to do inside and outside to get full thickness)
    for (_d=[0:30:330]) translate([46-wallThickness,shellWidth/2-wallThickness]) fanVane(_d);
}
module ioStand ()
{
    rotate([90,0,0]) linear_extrude(1.6) polygon([[-15,lidWallHeight],[0,lidWallHeight],[0,0]]);
}


//-- hooks to add additional elements
module hookBaseInside ()
{
    brdSupports([8.5,26.5,45]);
}
module hookLidInside ()
{
    // fanvanes
    fanVanes();
    // fanmounts
    fanMounts([[16,-16],[-16,16],[16,16],[-16,-16]]);
    // IO standups
    translate ([shellLength-wallThickness*2,21,-lidWallHeight]) ioStand();
    translate ([shellLength-wallThickness*2,39,-lidWallHeight]) ioStand();
}
module hookLidOutside ()
{
    // fanvanes
    fanVanes();
}


//---- This is where the magic happens ----
%YAPPgenerate();

//-- power button
*translate([2.5, pcbWidth+13, 0]) union() {
    cylinder(2, 2.5, 2.5, $fn=60);
    cylinder(6, 1.4, 1.4, $fn=60);
}

*pcb([3.5+wallThickness+paddingBack, 3.5+wallThickness+paddingLeft, basePlaneThickness+standoffHeight]);

