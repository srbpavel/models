/*
Camera case (half cylinder) for Raspberry Pi (model A/B) and Rasberry
Pi Camera module (v1).
Created for a security camera but also suitable for other camera purposes
By: Eric Buijs
version: 0.2
Date: 30 June 2018

CC BY-SA (explanation of Creative Common licenses: https://creativecommons.org/licenses/

The case consists of the following parts:
- front
- back
- lens
- lens hood
- camera holder

v0.2: Updated with stop ring for the lens module to prevent the lens to slide into the camera
*/

$fn = 50;
//dimensions of the case (parametric)
case_radius = 50;
case_height = 130;
case_thickness = 2;

lens_radius = 25;
lens_height = 20;

connector_height = 10;

//module to create a hollow cylinder
module connector(connector_height,r1,r2) {
    //connectors needed to attach two components together with a metal screw
    difference() {
        cylinder(r=r1,connector_height,center=true);
        cylinder(r=r2,connector_height+1,center=true);
    }
}

//module for top and bottom of the camera case
module half_cylinder(case_radius, case_thickness) {
    difference() {
        union() {
            cylinder(r=case_radius,h=case_thickness,center=true);
            translate([0,0,case_thickness]) cylinder(r=case_radius-case_thickness,h=case_thickness,center=true);
        }
        translate([case_radius,0,0]) cube([2*case_radius,2*case_radius,case_height+case_thickness+1], center=true);
    }
}

//module for stop ring over the lens (see module lens)
module lens_ring(lens_radius, case_radius) {
    difference() {
        connector(10, lens_radius+4, lens_radius);
        translate([0,0,case_radius-4]) rotate([0,90,0]) cylinder(r = case_radius, case_height, center = true);
    }
}

//module to create the back of the case.
module back_case(case_radius,case_height,case_thickness) {
    //carthesian coordinates of mounting points of the Raspberry Pi model A/B
    //other models will follow
    mAB = [[-15.5,37.5,4],[10,-16.5,4]];
    //model Zero
    mZ = [[-11.5,29,4],[11.5,29,4],[-11.5,-29,4],[11.5,-29,4]];
    difference() {
        union() {
            //back plate
            cube([2*case_radius-0.5,case_height+case_thickness,case_thickness],center=true);
            //inlay plate that fits into the front case
            translate([0,0,case_thickness]) cube([2*case_radius-2.5*case_thickness,case_height-2*case_thickness,case_thickness],center=true);
            //reference plate PCB size of Raspberry Pi model B
            //REMOVE REFERENCE CUBE BELOW BEFORE PRINTING!!!
            //translate([0,0,2*case_thickness]) cube([56,85,4],center=true);
            //Raspberry Pi mounts for model Zero. Change in case of other model
            for (i=[0:len(mAB)-1]) { //fill in Raspberry Pi type!
                translate(mAB[i])
                cylinder(r=4,h=6,center=true);
            }
            translate([0,-case_height/2,0])
            rotate([-90,0,0])
            rotate([0,0,90])
            difference() {
                union() {
                    half_cylinder(case_radius,case_thickness);
                    translate([-(case_radius-case_thickness-connector_height/2-1),0,2*case_thickness+3]) rotate([0,90,0]) connector(connector_height,6,2);
                }
            //entry for microUSB loader Raspberry Pi model A/B
            //CHANGE IN CASE OF OTHER MODEL RASPBERRY PI!!!
            translate([-10,-20,0]) cube([10,13,20],center=true);
            }
        }
        //hole to screw back_case to the front_case
        translate([0,60,0]) cylinder(r=2,h=10,center=true);
        //holes for the Raspberry Pi mount (x2) for model Zero
        for (i=[0:len(mAB)-1]) { //fill in Raspberry Pi type
            translate(mAB[i])
            cylinder(r=2,h=20,center=true);
        }
        //mounting backplate to wall
        translate([0,20,0]) cylinder(r=2.5,h=20,center=true);
        translate([0,-20,0]) cylinder(r=2.5,h=20,center=true);
    }
}

//module to create the cylindrical front of the case 
module front_case(case_radius,case_height,case_thickness,lens_radius,lens_height) {
    //cylinder shaped hull
    difference() {
        //basic cylinder shape of the case lid
        cylinder(r=case_radius, h=case_height, center=true);
        //this cylinder determines inside dimensions of the case
        cylinder(r=case_radius-case_thickness, h=case_height+1, center=true);
        //this cube creates half a cylinder
        translate([case_radius/2,0,0]) cube([case_radius,2*case_radius+1,case_height+1],center=true);
        //hole in the front to insert the lens
        translate([-case_radius,0,0]) rotate([0,90,0]) cylinder(r=lens_radius, h=lens_height, center=true);
        translate([-case_radius,0,-58]) rotate([0,90,0]) cylinder(r=2,h=10,center=true);
    }
    //top of the case including connector
    //connector is needed to attach the case lid to the bottom
    union() {
        //top cylinder
        translate([0,0,case_height/2]) rotate([180,0,0]) half_cylinder(case_radius,case_thickness);
        translate([-connector_height/2-2,0,case_height/2-5]) rotate([0,90,0]) connector(connector_height,6,2);
    }
}

////module to create a mount for the Raspberry Pi Camera
module camera_holder(x_size,y_size,z_size) {
    hx_size=15;
    hy_size=20;
    //mounting points for camera
    coord=[[6.5,10.5],[6.5,-10.5],[-6.5,10.5],[-6.5,-10.5]];
    $fn=50;
    difference() {
        translate([-(x_size-4)/2,-(y_size-4)/2,-z_size/2])
        minkowski() {
            cube([x_size-4,y_size-4,z_size/2]);
            cylinder(d=4,h=z_size/2);
        }
        //translate([0,hy_size/2-y_size/2,0]) 
        cube([hx_size,hy_size,z_size+1],center=true);
        //translate([0,hy_size/2-y_size/2,0])
        rotate([0,0,90]) 
        //small holes for to attach the camera mount to the case lid
        for (i=[0:3]) {
            translate(coord[i]) cylinder(r=1.5,h=10,center=true);
        };
    }
}

//module for the lens of the camera. The lens fits in the front case
//and is suitable for the 
module lens(lens_radius,lens_height) {
    hx_size=15;
    hy_size=20;
    //coord, coodinates for the camera mount holes
    coord=[[6.5,10.5],[6.5,-10.5],[-6.5,10.5],[-6.5,-10.5]];
    //d is thickness of wall
    d = 1.5;
    difference() {
        cylinder(r=lens_radius, h=lens_height, center=true);
        translate([0,0,-lens_height/2-d]) cylinder(r=lens_radius-case_thickness, h=lens_height, center=true);
        translate([0,0,lens_height/2]) cylinder(r=lens_radius-case_thickness, h=lens_height,center=true);
        //small holes for to attach the camera mount to the case lid
        for (i=[0:3]) {
            translate(coord[i]) cylinder(r=1.5,h=10,center=true);
        };
        cube([hy_size,hx_size,lens_height],center=true);
        //create space for ribbon cable
        translate([-lens_radius,0,10]) cube([10,16,10],center=true);
    }
    lens_ring(lens_radius, case_radius);
}

//lens hood module to protect the lens and reduce glare
//height1, height of the cylinder shape
//height2, height of the conical shape
module lens_hood(lens_radius,thickness,height1,height2) {
    //a simple lens hood to protect against glare
    conical_factor = 1.4;  //defines the angle of the conical shape 
    //center lens hood on the origin
    translate([0,0,-(height1+height2)/2]);
    difference() {
        //outer shape of the lens hood
        union() {
            cylinder(r=lens_radius+thickness,h=height1);
            translate([0,0,height1]) cylinder(r1=lens_radius+thickness, r2=conical_factor*lens_radius+thickness,h=height2);
        }
        //inner shape of the lens hood
        union() {
            translate([0,0,-1]) cylinder(r=lens_radius+0.3,h=height1+2);
            translate([0,0,height1]) cylinder(r1=lens_radius, r2=conical_factor*lens_radius,h=height2+1);
        }
    }
}

/* MAIN */
union() {
    //back_case
    translate([30,0,0]) rotate([0,-90,0]) rotate([0,0,-90]) color("darkseagreen") back_case(case_radius,case_height,case_thickness);
    //front_case
    color("grey")front_case(case_radius,case_height,case_thickness,lens_radius,lens_height);
    //camera holder
    translate([-case_radius+4,0,0]) rotate([0,-90,0]) rotate([0,0,90]) color("black") camera_holder(27,26,2);
    //lens
    translate([-case_radius-14,0,0]) color("lightgrey") rotate([0,90,0]) lens(lens_radius,lens_height);
    //lens hood
    translate([-90,0,0]) rotate([0,-90,0]) lens_hood(lens_radius,1.5,5,25);
}    