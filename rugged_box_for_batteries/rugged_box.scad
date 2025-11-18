//===============================================
// RUGGED BOX LIBRARY
// Modular library for hinged rugged boxes
// Rust-style enum-like structures for type safety
//===============================================

//===============================================
// VIEW PART ENUMS
//===============================================
VIEW_BOTH = "both";
VIEW_TOP = "top";
VIEW_BOTTOM = "bottom";

//===============================================
// POSITION ENUMS
//===============================================
POS_CENTER = "center";
POS_AT_HINGE = "at_hinge";

//===============================================
// HINGE OPEN ENUMS
//===============================================
HINGE_CLOSED = 0;
HINGE_QUARTER = -22.5;
HINGE_MID = -45;
HINGE_THREE_QUARTER = -67.5;
HINGE_OPEN = -90;
HINGE_OPEN_WIDE = -135;

//===============================================
// HINGE SPHERE LOCK PROTRUSION OPTIONS
//===============================================
HINGE_LOCK_NONE = 0;
HINGE_LOCK_EIGHTH = 1/8;
HINGE_LOCK_QUARTER = 1/4;
HINGE_LOCK_THIRD = 1/3;
HINGE_LOCK_HALF = 1/2;

//===============================================
// CONDITIONAL TRANSFORM MODULE
//===============================================

// Applies hinge transformation to children
// Like a rust wrapper pattern
module top_transform(top_part_position, hinge_state, box_length, box_shell, bottom_height, top_height) {
    if (top_part_position == POS_AT_HINGE) {
        // apply hinge transformation
        translate([-box_length/2 - box_shell, 0, bottom_height])
        rotate([180, hinge_state, 0])
        translate([box_length/2 + box_shell, 0, -top_height])
        children();
    } else {
        // no transform (center position)
        children();
    }
}

// Set color params
module set_color(flag, col, transp) {
    if (flag == true) {
        color(col, transp)
        children();
    } else {
        children();
    }
}

//===============================================
// MAIN BOX MODULE
//===============================================

module ruggedBox(
    length,
    width,
    height,
    fillet = 4,
    shell = 3,
    rib = 10,
    top = false,
    clearance = 0.3,
    fillHeight = 0,
    hinge_sphere_lock_protrusion = 0
) {
    union() {
        difference() {
            union() {
                translate([-length/2 + fillet + shell, -width/2 + fillet + shell, 0])
                union() {
                    // Lower part
                    minkowski() {
                        cube([length - 2*fillet - 2*shell, width - 2*fillet - 2*shell, height - shell]);
                        cylinder(r1 = fillet, r2 = fillet + shell, h = shell);
                    }

                    // Upper part
                    translate([0, 0, height - 2*shell])
                    minkowski() {
                        cube([length - 2*fillet - 2*shell, width - 2*fillet - 2*shell, shell]);
                        cylinder(r1 = fillet + shell, r2 = fillet + 2*shell, h = shell);
                    }
                }

                // Ribs
                oneRibY(length, width, height, fillet, shell, rib);
                mirror([1, 0, 0]) oneRibY(length, width, height, fillet, shell, rib);
                oneRibX(length, width, height, fillet, shell, rib);
                mirror([0, 1, 0]) oneRibX(length, width, height, fillet, shell, rib);

                // Top rabbet
                if (top == true) topRabbet(length, width, height, fillet, shell);
            }

            // Inside cut out
            translate([-length/2 + fillet + shell, -width/2 + fillet + shell, shell + fillHeight])
            minkowski() {
                cube([length - 2*fillet - 2*shell, width - 2*fillet - 2*shell, height - 2*shell + 0.1]);
                cylinder(r = fillet, h = shell);
            }

            // Bottom rabbet cutout
            if (top == false) bottomRabbet(length, width, height, fillet, shell);

            // Bottom hinge cutout
            if (top == false) {
                translate([-length/2 - shell, 0, height])
                rotate([90, 90, 0])
                cylinder(d = 2*shell + 2*clearance, h = width - 2*fillet + rib - 8*shell + 2*clearance, center = true);
            }

            // Top hinge cutout
            if (top == true) {
                translate([-length/2 - shell, 0, height])
                rotate([90, 90, 0])
                cylinder(d = 2*shell + 2*clearance, h = width - 2*fillet - rib - 8*shell + 2*clearance, center = true);

                translate([-length/2 - shell, 0, height])
                rotate([90, 90, 0])
                cylinder(d = shell + 2*clearance, h = width - 2*fillet - 6*shell, center = true);
            }
        }

        // Bottom hinge
        if (top == false) {
            translate([-length/2 - shell, 0, height])
            rotate([90, 90, 0])
            cylinder(d = 2*shell, h = width - 2*fillet - rib - 8*shell, center = true);

            // left sphere lock
            translate([-length/2 - shell,
                -(width - 2*fillet - rib - 8.2*shell)/2 - hinge_sphere_lock_protrusion,
                height
            ])
            sphere(d = shell);

            // right sphere lock
            translate([-length/2 - shell,
                (width - 2*fillet - rib - 8.2*shell)/2 + hinge_sphere_lock_protrusion,
                height
            ])
            sphere(d = shell);

            difference() {
                union() {
                    translate([-length/2 - shell - 0.1*shell, 0, height - 2.5*shell])
                    cube([1.8*shell, width - 2*fillet - rib - 8*shell, 5*shell], center = true);

                    translate([-length/2 - shell, 0, height - 3*shell])
                    cube([2*shell, width - 2*fillet - rib - 8*shell, 4*shell], center = true);
                }

                translate([-length/2 - shell, 0, height - 5*shell])
                rotate([0, -45, 0])
                cube([2*shell, width, 10*shell], center = true);
            }
        }

        // Top hinge
        if (top == true) {
            topHingeSide(length, width, height, fillet, shell, clearance, rib);
            mirror([0, 1, 0]) topHingeSide(length, width, height, fillet, shell, clearance, rib);
        }

        // Top snap lid
        if (top == true) {
            difference() {
                union() {
                    translate([length/2 + 1.5*shell, 0, height])
                    cube([shell, width - 2*fillet - rib - 8*shell - clearance, 6*shell], center = true);

                    translate([length/2 + 0.5*shell, 0, height - 2*shell])
                    cube([shell, width - 2*fillet - rib - 8*shell, 4*shell], center = true);

                    translate([length/2 + 1.1*shell, 0, height + 1.5*shell + 2*clearance])
                    rotate([90, 90, 0])
                    cylinder(d = shell, h = width - 2*fillet - rib - 8*shell - clearance, center = true);
                }

                translate([length/2 + shell, 0, height - 4*shell])
                rotate([0, 45, 0])
                cube([2*shell, width, 10*shell], center = true);

                translate([length/2 + shell, (width - 2*fillet - rib - 8*shell)/2, height + 4*shell])
                rotate([45, 0, 0])
                cube([10*shell, 3*shell, 10*shell], center = true);

                translate([length/2 + shell, -(width - 2*fillet - rib - 8*shell)/2, height + 4*shell])
                rotate([-45, 0, 0])
                cube([10*shell, 3*shell, 10*shell], center = true);

                translate([length/2 + shell, 0, height + 4.8*shell])
                rotate([0, 45, 0])
                cube([3*shell, width, 10*shell], center = true);
            }
        }
    }
}

//===============================================
// HELPER MODULES
//===============================================

// Helper module for top hinge
module topHingeSide(length, width, height, fillet, shell, clearance, rib) {
    difference() {
        union() {
            translate([-length/2 - shell, (width/2 - fillet - 4*shell + 0.5*clearance), height])
            rotate([90, 90, 0])
            cylinder(d = 2*shell, h = rib - clearance, center = true);

            translate([-length/2 - shell, (width/2 - fillet - 4*shell + 0.5*clearance), height - 2*shell])
            cube([2*shell, rib - clearance, 4*shell], center = true);
        }

        translate([-length/2 - shell, (width - 2*fillet - rib - 8*shell)/2, height])
        sphere(d = shell);

        translate([-length/2 - shell, (width - 2*fillet - rib - 8.3*shell + clearance)/2, height])
        rotate([0, -90, 0])
        cylinder(h = shell + 0.1, d = shell);

        translate([-length/2 - shell, 0, height - 4*shell])
        rotate([0, -45, 0])
        cube([2*shell, width, 10*shell], center = true);
    }
}

// Helper module for bottom rabbet
module bottomRabbet(length, width, height, fillet, shell) {
    translate([-length/2 + fillet + shell, -width/2 + fillet + shell, height - shell/8*7])
    difference() {
        minkowski() {
            cube([length - 2*fillet - 2*shell, width - 2*fillet - 2*shell, shell/3*2]);
            cylinder(r1 = fillet + 1.1*shell, r2 = fillet + 1.5*shell, h = shell/3);
        }
        minkowski() {
            cube([length - 2*fillet - 2*shell, width - 2*fillet - 2*shell, 0.001]);
            cylinder(r1 = fillet + 0.9*shell, r2 = fillet + 0.5*shell, h = shell/3);
        }
        minkowski() {
            cube([length - 2*fillet - 2*shell, width - 2*fillet - 2*shell, shell/2 + 0.001]);
            cylinder(r = fillet + 0.5*shell, h = shell/2);
        }
    }
}

// Helper module for top rabbet
module topRabbet(length, width, height, fillet, shell) {
    translate([-length/2 + fillet + shell, -width/2 + fillet + shell, height])
    difference() {
        minkowski() {
            cube([length - 2*fillet - 2*shell, width - 2*fillet - 2*shell, 0.001]);
            cylinder(r1 = fillet + 1.5*shell, r2 = fillet + 1.1*shell, h = shell/2);
        }
        minkowski() {
            translate([0, 0, -0.001])
            cube([length - 2*fillet - 2*shell, width - 2*fillet - 2*shell, 0.105]);
            cylinder(r1 = fillet + 0.5*shell, r2 = fillet + 0.9*shell, h = shell/2);
        }
    }
}

// Helper module for ribs
module oneRibY(length, width, height, fillet, shell, rib) {
    intersection() {
        translate([-length/2 + fillet + shell, -width/2 + fillet + shell, 0])
        minkowski() {
            cube([length - 2*fillet - 2*shell, width - 2*fillet - 2*shell, height - shell]);
            cylinder(r1 = fillet + shell, r2 = fillet + 2*shell, h = shell);
        }

        translate([length/2 - fillet - 4*shell, 0, 1])
        cube([rib, 2*width, 2*height], center = true);
    }
}

// Helper module for ribs
module oneRibX(length, width, height, fillet, shell, rib) {
    intersection() {
        translate([-length/2 + fillet + shell, -width/2 + fillet + shell, 0])
        minkowski() {
            cube([length - 2*fillet - 2*shell, width - 2*fillet - 2*shell, height - shell]);
            cylinder(r1 = fillet + shell, r2 = fillet + 2*shell, h = shell);
        }

        translate([0, width/2 - fillet - 4*shell, 1])
        cube([2*length, rib, 2*height], center = true);
    }
}
