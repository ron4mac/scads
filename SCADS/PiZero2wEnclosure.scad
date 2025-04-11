/*
This YAPP_generator sample is for a raspberry pi zero 2w case
*/
include <YAPPgenerator_v3.scad>

printBaseShell      = true;
printLidShell       = true;

//-- pcb dimensions -- very important!!!
// Electro cookie 30 row
pcbLength           = 65; // Front to back
pcbWidth            = 30; // Side to side
pcbThickness        = 1.5;
                            
//-- padding between pcb and inside wall
paddingFront        = 1;
paddingBack         = 0.4;
paddingRight        = 2;
paddingLeft         = 0.4;

//-- Edit these parameters for your own box dimensions
wallThickness       = 1.6;
basePlaneThickness  = 1.6;
lidPlaneThickness   = 1.6;

//-- Total height of box = lidPlaneThickness 
//                       + lidWallHeight 
//--                     + baseWallHeight 
//                       + basePlaneThickness
//-- space between pcb and lidPlane :=
//--      (bottonWallHeight+lidWallHeight) - (standoffHeight+pcbThickness)
baseWallHeight      = pcbThickness + 2.2;
lidWallHeight       = 9;

//-- ridge where base and lid off box can overlap
//-- Make sure this isn't less than lidWallHeight
ridgeHeight         = 0.5;
ridgeSlack          = 0.2;
roundRadius         = 1.0;

//-- How much the PCB needs to be raised from the base
//-- to leave room for solderings and whatnot
standoffHeight      = 2;
standoffPinDiameter = 2.7;
standoffHoleSlack   = 0;
standoffDiameter    = 6.4;

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
    [3.5, 23+3.5, yappHole, yappBaseOnly, yappNoFillet],
    [58+3.5, 3.5, yappHole, yappBaseOnly, yappNoFillet],
    [58+3.5, 23+3.5, yappHole, yappBaseOnly, yappNoFillet]
];

snapJoins = [
//    [shellWidth/2, 8, yappBack, yappCenter],
//    [shellLength-19, 8, yappLeft, yappRight, yappCenter]
];

//-- C U T O U T S ---------------------------------------
// left cutout
cutoutsLeft = [
[6.6,pcbThickness-.32,11.8,5,0,yappRectangle],
[37.4,pcbThickness-.32,7.9,3.2,0,yappRectangle],
[50.2,pcbThickness-.32,7.9,3.2,0,yappRectangle],
];
// front cutouts
cutoutsFront = [
];

cutoutsLid = [
[3.5, 3.5,4.9,2.83,1.25,yappCircle,yappCenter,0],
[3.5, 23+3.5,4.9,2.83,1.25,yappCircle,yappCenter,0],
[58+3.5, 3.5,4.9,2.83,1.25,yappCircle,yappCenter,0],
[58+3.5, 23+3.5,4.9,2.83,1.25,yappCircle,yappCenter,0],
[8,15.4,2.4,26,0,yappRectangle,yappCenter],
[14,15.4,2.4,26,0,yappRectangle,yappCenter],
[20,15.4,2.4,26,0,yappRectangle,yappCenter],
[26,15.4,2.4,26,0,yappRectangle,yappCenter],
[32,15.4,2.4,26,0,yappRectangle,yappCenter],
[38,15.4,2.4,26,0,yappRectangle,yappCenter],
[44,15.4,2.4,26,0,yappRectangle,yappCenter],
[50,15.4,2.4,26,0,yappRectangle,yappCenter],
[56,15.4,2.4,26,0,yappRectangle,yappCenter],
];

cutoutsBack = [
[10.5,pcbThickness-.32,13,2,0,yappRectangle],
];

cutoutsBase = [
[3.5, 3.5,5.2,2.99,0,yappRectangle,yappCenter,0],
[3.5, 3.5,5.2,2.99,0,yappRectangle,yappCenter,60],
[3.5, 3.5,5.2,2.99,0,yappRectangle,yappCenter,120],
[3.5, 23+3.5,5.2,2.99,0,yappRectangle,yappCenter,0],
[3.5, 23+3.5,5.2,2.99,0,yappRectangle,yappCenter,60],
[3.5, 23+3.5,5.2,2.99,0,yappRectangle,yappCenter,120],
[58+3.5, 3.5,5.2,2.99,0,yappRectangle,yappCenter,0],
[58+3.5, 3.5,5.2,2.99,0,yappRectangle,yappCenter,60],
[58+3.5, 3.5,5.2,2.99,0,yappRectangle,yappCenter,120],
[58+3.5, 23+3.5,5.2,2.99,0,yappRectangle,yappCenter,0],
[58+3.5, 23+3.5,5.2,2.99,0,yappRectangle,yappCenter,60],
[58+3.5, 23+3.5,5.2,2.99,0,yappRectangle,yappCenter,120],
];

// the printed circuit board
module pcb (xyz) {
    translate(xyz) difference() {
        color("Cyan", 0.7) linear_extrude(pcbThickness) hull () {
            circle(3.5);
            translate([0,23,0]) circle(3.5);
            translate([58,23,0]) circle(3.5);
            translate([58,0,0]) circle(3.5);
        }
        cylinder(2,1);
        translate([0,23,0]) cylinder(2,1);
        translate([58,23,0]) cylinder(2,1);
        translate([58,0,0]) cylinder(2,1);
    }
}
//-- modules used by hooks
module hexNut ()
{
    rotate([0,0,deg]) translate([6,-.6,0]) rotate([0,0,-110]) cube([21,1.2,lidPlaneThickness]);
}


//-- hooks to add additional elements
module hookBaseInside ()
{
}
module hookLidInside ()
{
}
module hookLidOutside ()
{
}


//---- This is where the magic happens ----
%YAPPgenerate();

*pcb([3.5+wallThickness+paddingBack, 3.5+wallThickness+paddingLeft, basePlaneThickness+standoffHeight]);

