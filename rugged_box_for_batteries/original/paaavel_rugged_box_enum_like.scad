// ============================================================================
// CONFIGURATION - enum like constants / rust style
// ============================================================================


// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations#color
// https://www.w3.org/TR/css-color-3/
//
//COLOR_TOP_BOOL = true;
COLOR_TOP_BOOL = false;
//COLOR_TOP_TRANSP = 1;
COLOR_TOP_TRANSP = 0.5;
//COLOR_TOP = [1, 1, 1];
COLOR_TOP = "magenta";

//COLOR_BOTTOM_BOOL = true;
COLOR_BOTTOM_BOOL = false;
//COLOR_BOTTOM_TRANSP = 1;
COLOR_BOTTOM_TRANSP = 0.3;
//COLOR_BOTTOM = [0.5, 0.5, 1];
COLOR_BOTTOM = "lime";

// view part enum
VIEW_BOTH = "both";
VIEW_TOP = "top";
VIEW_BOTTOM = "bottom";

// position enum  
POS_CENTER = "center";
POS_AT_HINGE = "at_hinge";

// hindge open enum
HINGE_CLOSED = 0;
HINGE_QUARTER = -22.5;
HINGE_MID = -45;
HINGE_THREE_QUARTER = -67.5;
HINGE_OPEN = -90;

HINDGE_SPHERE_LOCK_PROTRUSION = 0;
//HINDGE_SPHERE_LOCK_PROTRUSION = 1/8;
//HINDGE_SPHERE_LOCK_PROTRUSION = 1/4;
//HINDGE_SPHERE_LOCK_PROTRUSION = 1/3;
//HINDGE_SPHERE_LOCK_PROTRUSION = 1/2;

// ============================================================================
// USER PARAMETERS
// ============================================================================

// select which part to view
view_part = VIEW_BOTH;
//view_part = VIEW_TOP;
//view_part = VIEW_BOTTOM;

// select top part position
//top_part_position = POS_CENTER;
top_part_position = POS_AT_HINGE;

// box dimensions
//
// side where the hindge and lock is
box_length = 55*1;
box_width = 55*2;
total_height = 50;  // total height for both parts combined

// parts ratio (bottom:top)
ratio_bottom_to_top = 3;  // 3 means bottom is 3x taller than top

// box parameters
box_fillet = 4;       // fillet radius [4-20]
box_shell = 3;        // shell thickness [3-9] / also apply for rib
box_rib = 6;         // rib thickness [6-20]
box_clearance = 0.3;  // hinge clearance
box_fillHeight = 0;   // fill of inner space

// Render quality
render_quality_multiple=1;
//render_quality_multiple=2;
//render_quality_multiple=3;
//render_quality_multiple=4;
//render_quality_multiple=5;
$fn = 64 * render_quality_multiple;

// ============================================================================
// DERIVED CALCULATIONS (like rust let bindings)
// ============================================================================

// calculate heights based on ratio
top_height = total_height / (ratio_bottom_to_top + 1);
bottom_height = top_height * ratio_bottom_to_top;

// Select hinge state
//hinge_state = HINGE_OPEN;
hinge_state = HINGE_THREE_QUARTER;
//hinge_state = HINGE_MID;
//hinge_state = HINGE_QUARTER;
//hinge_state = HINGE_CLOSED;
  
// ============================================================================
// CONDITIONAL TRANSFORM MODULE (avoids code duplication)
// ============================================================================

// applies hinge transformation to children
// like a rust wrapper pattern
module top_transform() {
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

// set color params
//
module set_color(flag, col, transp) {
  if (flag == true) { 
    color(col, transp)
      children();
  } else {
    children();
  }
}

// ============================================================================
// MAIN RENDERING LOGIC
// ============================================================================


// render top part (single ruggedBox call, conditionally wrapped)
if (view_part == VIEW_TOP || view_part == VIEW_BOTH) {
  set_color(COLOR_TOP_BOOL, COLOR_TOP, COLOR_TOP_TRANSP)
    top_transform()
    ruggedBox(
	      box_length,
	      box_width,
	      top_height, // top
	      fillet = box_fillet,
	      shell = box_shell,
	      rib = box_rib,
	      top = true, // top
	      clearance = box_clearance,
	      fillHeight = box_fillHeight
	      );
 }

// render bottom part (always at origin)
if (view_part == VIEW_BOTTOM || view_part == VIEW_BOTH) {
  set_color(COLOR_BOTTOM_BOOL, COLOR_BOTTOM, COLOR_BOTTOM_TRANSP)
    ruggedBox(
	      box_length,
	      box_width,
	      bottom_height, // bottom
	      fillet = box_fillet,
	      shell = box_shell,
	      rib = box_rib,
	      top = false, // bottom
	      clearance = box_clearance,
	      fillHeight = box_fillHeight
	      );
 }

// ============================================================================
// EXAMPLE CONFIGURATIONS (from original)
// ============================================================================

showExample = false;
showExampleCombined = false;

outSideLength = 55;
outSideWidth = 55;
outSideHeight = 50;
shellThickness = 3;
ribThickness = 10;
filletRadius = 4;

heiBottom = 0.7 * outSideHeight;
heiTop = outSideHeight - heiBottom;

// Example: side by side
if (showExample) {
  // Top
  color([1,1,1])
  translate([0, 2*outSideWidth + 8*shellThickness, 0])
  ruggedBox(
    length = outSideLength,
    width = outSideWidth,
    height = heiTop,
    fillet = filletRadius,
    shell = shellThickness,
    rib = ribThickness,
    top = true
  );

  // Bottom
  color([0.5, 0.5, 1])
  translate([0, outSideWidth + 4*shellThickness, 0])
  ruggedBox(
    length = outSideLength,
    width = outSideWidth,
    height = heiBottom,
    fillet = filletRadius,
    shell = shellThickness,
    rib = ribThickness,
    top = false,
    fillHeight = 0
  );
}

// Example: combined at hinge
if (showExampleCombined) {
  // Top
  color([1,1,1])
  translate([-outSideLength/2 - heiTop - shellThickness, 0, 
             outSideHeight + outSideLength/2 - heiTop + shellThickness])
  rotate([0, 270, 180])
  ruggedBox(
    length = outSideLength,
    width = outSideWidth,
    height = heiTop,
    fillet = filletRadius,
    shell = shellThickness,
    top = true
  );

  // Bottom
  color([0.5, 0.5, 1])
  ruggedBox(
    length = outSideLength,
    width = outSideWidth,
    height = heiBottom,
    fillet = filletRadius,
    shell = shellThickness,
    top = false,
    fillHeight = 0
  );
}

// ============================================================================
// MAIN BOX MODULE
// ============================================================================

module ruggedBox(
  length,
  width,
  height,
  fillet = 4,
  shell = 3,
  rib = 10,
  top = false,
  clearance = 0.3,
  fillHeight = 0
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

      // left
      translate([-length/2 - shell,
		 //-(width - 2*fillet - rib - 8.2*shell)/2,
		 -(width - 2*fillet - rib - 8.2*shell)/2 - HINDGE_SPHERE_LOCK_PROTRUSION,
		 height
		 ])
      //
      //sphere(d = shell);
      sphere(d = shell+0);

      // right
      translate([-length/2 - shell,
		 //(width - 2*fillet - rib - 8.2*shell)/2,
		 (width - 2*fillet - rib - 8.2*shell)/2 + HINDGE_SPHERE_LOCK_PROTRUSION,
		 height
		 ])
      //sphere(d = shell);
      sphere(d = shell+0);
      
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

// ============================================================================
// HELPER MODULES
// ============================================================================

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
