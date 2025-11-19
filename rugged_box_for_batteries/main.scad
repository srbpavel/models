//===============================================
// RUGGED BOX FOR BATTERIES - MAIN CONFIGURATION
// Unified configuration for battery holder + rugged box system
//===============================================
/*

QUICK START GUIDE:

This is a fully parametric system for generating rugged boxes with
integrated battery spacers. Everything is configured through enums
and parameters below - no code modification needed.

BASIC WORKFLOW:
1. Select battery type (BATTERY_FENIX_BLACK, BATTERY_RED, etc.)
2. Define matrix size [columns, rows] - e.g. [3, 5] for 15 batteries
3. Choose design preset (COMPACT, ROBUST, TIGHT)
4. View the assembly (default view_mode)
5. Export STL files by changing view_mode

QUICK-START PRESETS:

Small Travel Box (6 batteries):
  SELECTED_BATTERY = BATTERY_RED;
  MATRIX = [2, 3];
  SELECTED_DESIGN = DESIGN_COMPACT;
  Result: ~45x68x70mm box

Medium Storage Box (15 batteries):
  SELECTED_BATTERY = BATTERY_FENIX_BLACK;
  MATRIX = [3, 5];
  SELECTED_DESIGN = DESIGN_ROBUST;
  Result: ~82x123x83mm box

Large Power Bank (20 batteries):
  SELECTED_BATTERY = BATTERY_FENIX_USB_C;
  MATRIX = [4, 5];
  SELECTED_DESIGN = DESIGN_COMPACT;
  Result: ~102x124x85mm box

FEATURES:
- Auto-calculated dimensions (box adjusts to battery + matrix)
- Hinged lid with snap lock (watertight design)
- Removable spacer (take out for drying if needed)
- Battery visualization (see fit before printing)
- Spacer height adjustment (position in box bottom)
- Optional features available (drainage, ventilation, label, mounting)
- Rust-style enum configuration (no magic numbers)

STL EXPORT:
1. Set view_mode to SHOW_BOX_BOTTOM, SHOW_BOX_LID, or SHOW_SPACER
2. Render (F6) and Export STL (F7)
3. Each part is pre-oriented for optimal printing

*/

// Import libraries (use<> for modules only, no namespace pollution)
use </home/conan/git/models/rugged_box_for_batteries/battery_holder.scad>
use </home/conan/git/models/rugged_box_for_batteries/rugged_box.scad>

// Include for constants and functions (we need these in scope)
include </home/conan/git/models/rugged_box_for_batteries/battery_holder.scad>
include </home/conan/git/models/rugged_box_for_batteries/rugged_box.scad>

//===============================================
// VIEW MODE ENUMS
//===============================================
SHOW_BOX_ONLY = "box_only";              // Box bottom + lid at hinge
SHOW_BOX_BOTTOM = "box_bottom";          // Only bottom half (for STL export)
SHOW_BOX_LID = "box_lid";                // Only lid (for STL export)
SHOW_SPACER = "spacer";                  // Only battery spacer (for STL export)
SHOW_BOX_WITH_SPACER = "box_with_spacer"; // Complete assembly view
SHOW_ALL_SEPARATED = "all_separated";    // All parts laid out for inspection

//===============================================
// SPACER PLACEMENT (always in bottom, removable for drying)
//===============================================

//===============================================
// SPACER HEIGHT MODES
//===============================================
HEIGHT_FULL_BATTERY = "full_battery";   // Full battery height (pins hidden)
HEIGHT_ALIGN_BOTTOM = "align_bottom";   // Align with bottom part edge
HEIGHT_HALF = "half";                   // Half battery height
HEIGHT_CUSTOM = "custom";               // Custom test height

//===============================================
// FEATURE FLAGS (true/false)
//===============================================
FEATURE_ENABLE = true;
FEATURE_DISABLE = false;

//===============================================
// RENDER QUALITY
//===============================================
render_quality_multiple = 1;
//render_quality_multiple = 2;
//render_quality_multiple = 3;
$fn = 64 * render_quality_multiple;

//===============================================
// BATTERY CONFIGURATION
//===============================================

// Select battery type (choose one)
//SELECTED_BATTERY = BATTERY_FENIX_BLACK;
//SELECTED_BATTERY = BATTERY_FENIX_ORANGE;
SELECTED_BATTERY = BATTERY_FENIX_USB_C;
//SELECTED_BATTERY = BATTERY_RED;
//SELECTED_BATTERY = BATTERY_GREEN;

// Define battery matrix [columns, rows]
MATRIX = [3, 5];
//MATRIX = [2, 3];
//MATRIX = [4, 5];

//===============================================
// MANUFACTURING & DESIGN CONFIGURATION
//===============================================

// Select manufacturing profile
SELECTED_MFG = MFG_STANDARD_FDM;
//SELECTED_MFG = MFG_PRECISION;
//SELECTED_MFG = MFG_DRAFT;

// Battery holder design parameters (override library defaults)
design_battery_clearance = 0.3;   // radial gap between battery and hole (mm)
//design_battery_clearance = 0.5;   // radial gap between battery and hole (mm)
design_wall_between = 1.2;         // wall thickness between batteries (mm)
design_wall_thickness = 1.6;       // wall around each battery (mm)
design_outer_wall = 2.0;           // outer perimeter wall (mm)
design_bottom_thickness = 2.0;     // bottom thickness (mm)
design_top_rim_height = 2.0;       // rim height above batteries (mm)

// Create custom design from main.scad parameters
SELECTED_DESIGN = [
    design_wall_thickness,
    design_wall_between,
    design_bottom_thickness,
    design_top_rim_height,
    design_outer_wall,
    design_battery_clearance
];

//===============================================
// BOX CONFIGURATION
//===============================================

// Holder dimensions for XY sizing only
holder_dims = calc_holder_dimensions(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX);

// Margin around spacer inside box (mm)
//spacer_margin_xy = 0.5;  // horizontal clearance (tight fit, easily removable)
spacer_margin_xy = 1.0;  // moderate clearance
//spacer_margin_xy = 2.0;  // loose fit (original - too much gap!)
spacer_margin_z = 0;     // no gap - spacer sits directly on bottom

// Spacer fillet radius (rounded corners to match box inner shape)
spacer_fillet = 3.5;     // slightly less than box_fillet for clearance
//spacer_fillet = 0;     // square corners (no fillet)

//===============================================
// ️ CRITICAL PARAMETER: AIR GAP CONTROL ️
//===============================================
// Gap between battery pin top and closed lid inner surface
// This is THE MOST IMPORTANT dimension - controls battery fit!
// Common values:
//   1mm = very tight fit (risk of pressure on batteries)
//   2mm = tight fit (minimal air gap)
//   3mm = normal fit (small air gap)
//   5mm = safe clearance (recommended default)
//  10mm = extra safety (large air gap)

//battery_top_clearance = 5;  // mm - CHANGE THIS to control air gap
//battery_top_clearance = 1;  // mm - very tight
battery_top_clearance = 2;  // mm - tight fit
//battery_top_clearance = 3;  // mm - normal

// Calculate inner box dimensions to fit spacer
box_inner_length = holder_dims[0] + spacer_margin_xy * 2;
box_inner_width = holder_dims[1] + spacer_margin_xy * 2;

// Box shell and structure parameters
box_fillet = 4;       // fillet radius [4-20]
box_shell = 3;        // shell thickness [3-9] / also applies for rib
box_rib = 6;          // rib thickness [6-20]
box_clearance = 0.3;  // hinge clearance
box_fillHeight = 0;   // fill of inner space

// Calculate outer box dimensions (add shell thickness only - fillet is added by minkowski)
box_length = box_inner_length + 2 * box_shell;
box_width = box_inner_width + 2 * box_shell;

// Total box height - calculated from BATTERY height + clearances
// Spacer now starts at z=0, no fillet offset needed
total_height = box_shell * 2 + spacer_margin_z + bat_total_height(SELECTED_BATTERY) + battery_top_clearance;

// Parts ratio (bottom:top)
ratio_bottom_to_top = 3;  // 3 means bottom is 3x taller than top

// Calculate heights based on ratio
top_height = total_height / (ratio_bottom_to_top + 1);
bottom_height = top_height * ratio_bottom_to_top;

//===============================================
// HINGE CONFIGURATION
//===============================================

// Select hinge state

hinge_state = HINGE_OPEN_WIDE;
//hinge_state = HINGE_OPEN;
//hinge_state = HINGE_THREE_QUARTER;
//hinge_state = HINGE_MID;
//hinge_state = HINGE_QUARTER;
//hinge_state = HINGE_CLOSED;

// Select top part position
top_part_position = POS_AT_HINGE;
//top_part_position = POS_CENTER;

// Hinge sphere lock protrusion
//hinge_sphere_lock = HINGE_LOCK_NONE;
//hinge_sphere_lock = HINGE_LOCK_EIGHTH;
hinge_sphere_lock = HINGE_LOCK_QUARTER;

//===============================================
// SPACER CONFIGURATION
//===============================================

// Spacer height mode selection
//spacer_height_mode = HEIGHT_FULL_BATTERY;
//spacer_height_mode = HEIGHT_ALIGN_BOTTOM;  // Flush with bottom part top edge
spacer_height_mode = HEIGHT_HALF;          // Quick test at 1/2 height
//spacer_height_mode = HEIGHT_CUSTOM;        // Custom test height

// Custom height (ONLY used when HEIGHT_CUSTOM selected, otherwise IGNORED)
spacer_custom_height = 5;  // mm

// Show batteries (visualization for fit checking)
// Works in all view modes: SHOW_BOX_ONLY, SHOW_BOX_WITH_SPACER, SHOW_SPACER, SHOW_ALL_SEPARATED
show_batteries = true;
//show_batteries = false;

// Show dummy measurement objects (gap visualization cubes)
show_dummy_objects = true;
//show_dummy_objects = false;

// Lid surface dummy thickness (thin surface visualization)
dummy_lid_thickness = 0.01;         // mm (smallest possible)

//===============================================
// COLOR CONFIGURATION
//===============================================

COLOR_TOP_BOOL = false;
//COLOR_TOP_BOOL = true;
COLOR_TOP_TRANSP = 0.3;          // VERY transparent to see through when closed!
COLOR_TOP = "magenta";

COLOR_BOTTOM_BOOL = false;
//COLOR_BOTTOM_BOOL = true;
COLOR_BOTTOM_TRANSP = 0.3;       // VERY transparent to see inside
COLOR_BOTTOM = "lime";

COLOR_SPACER_BOOL = false;
//COLOR_SPACER_BOOL = true;
COLOR_SPACER_TRANSP = 0.7;       // VERY transparent to see batteries through it!
COLOR_SPACER = "cyan";

//COLOR_BATTERY_BOOL = false;      // false = use battery spec color
COLOR_BATTERY_BOOL = true;       // true = use custom color below
COLOR_BATTERY_TRANSP = 0.5;      // SOLID (0.0) - batteries must be CLEARLY visible!
//COLOR_BATTERY_TRANSP = 1.0;      // SOLID (0.0) - batteries must be CLEARLY visible!
COLOR_BATTERY = "red";           // bright color for visibility

// Dummy measurement objects color
COLOR_DUMMY = "magenta";          // Dummy cubes color
COLOR_DUMMY_TRANSP = 1;        // Dummy cubes transparency
//COLOR_DUMMY_TRANSP = 0.3;        // Dummy cubes transparency

//===============================================
// VIEW MODE SELECTION
//===============================================

// Select which parts to view
view_mode = SHOW_BOX_WITH_SPACER;  // Full assembly: bottom + top + spacer
//view_mode = SHOW_BOX_ONLY;         // Box only: bottom + top (no spacer)
//view_mode = SHOW_BOX_BOTTOM;       // STL export: bottom only
//view_mode = SHOW_BOX_LID;          // STL export: lid only
//view_mode = SHOW_SPACER;           // STL export: spacer only
//view_mode = SHOW_ALL_SEPARATED;    // All parts separated

//===============================================
// INFORMATION OUTPUT
//===============================================

echo("=== RUGGED BOX FOR BATTERIES ===");
echo(str("Battery: ", bat_name(SELECTED_BATTERY)));
echo(str("Matrix: ", MATRIX[0], " x ", MATRIX[1], " = ", MATRIX[0] * MATRIX[1], " cells"));
echo(str("Holder dimensions: ", holder_dims[0], " x ", holder_dims[1], " x ", holder_dims[2], "mm"));
echo(str("Box outer dimensions: ", box_length, " x ", box_width, " x ", total_height, "mm"));
echo(str("Box inner dimensions: ", box_inner_length, " x ", box_inner_width, "mm"));
echo(str("Bottom height: ", bottom_height, "mm, Top height: ", top_height, "mm"));

//===============================================
// RENDERING LOGIC
//===============================================

// Calculate spacer position inside box
// Spacer is now CENTERED at origin (like box), only need Z offset
spacer_offset_z = box_shell + spacer_margin_z;

// Calculate actual battery position - sits directly on spacer base
battery_base_z = spacer_offset_z;

echo("");
echo("=== CRITICAL GAP VERIFICATION ===");
echo(str("Battery total height: ", bat_total_height(SELECTED_BATTERY), "mm"));
echo(str("Spacer bottom position: ", spacer_offset_z, "mm (box_shell + spacer_margin_z)"));
echo(str("Battery bottom position: ", battery_base_z, "mm (on spacer base)"));
echo(str("Battery top position: ", battery_base_z + bat_total_height(SELECTED_BATTERY), "mm"));
echo(str("Box inner top: ", total_height - box_shell, "mm (total_height - box_shell)"));
echo(str("Actual gap: ", (total_height - box_shell) - (battery_base_z + bat_total_height(SELECTED_BATTERY)), "mm"));
echo(str("Configured battery_top_clearance: ", battery_top_clearance, "mm"));
echo(str("Gap matches configuration: ", abs((total_height - box_shell) - (battery_base_z + bat_total_height(SELECTED_BATTERY)) - battery_top_clearance) < 0.01 ? "YES ✓" : "NO ✗"));

// Calculate actual spacer print height based on mode
actual_spacer_height =
    spacer_height_mode == HEIGHT_FULL_BATTERY ? bat_total_height(SELECTED_BATTERY) :
    spacer_height_mode == HEIGHT_ALIGN_BOTTOM ? (bottom_height - box_shell - spacer_margin_z) :
    spacer_height_mode == HEIGHT_HALF ? (bat_total_height(SELECTED_BATTERY) / 2) :
    spacer_custom_height;  // HEIGHT_CUSTOM mode

//===============================================
// BOX ASSEMBLY MODULE (Rust-style composition)
//===============================================
// Renders box parts with proper color and transformations
// Uses children() pattern to avoid repetitive ruggedBox calls

module box_assembly(show_bottom = true, show_top = true) {
    // Render bottom part
    if (show_bottom) {
        set_color(COLOR_BOTTOM_BOOL, COLOR_BOTTOM, COLOR_BOTTOM_TRANSP) {
            ruggedBox(
                box_length,
                box_width,
                bottom_height,
                fillet = box_fillet,
                shell = box_shell,
                rib = box_rib,
                top = false,
                clearance = box_clearance,
                fillHeight = box_fillHeight,
                hinge_sphere_lock_protrusion = hinge_sphere_lock
            );
        }
    }

    // Render top part
    if (show_top) {
        set_color(COLOR_TOP_BOOL, COLOR_TOP, COLOR_TOP_TRANSP) {
            top_transform(top_part_position, hinge_state, box_length, box_shell, bottom_height, top_height) {
                ruggedBox(
                    box_length,
                    box_width,
                    top_height,
                    fillet = box_fillet,
                    shell = box_shell,
                    rib = box_rib,
                    top = true,
                    clearance = box_clearance,
                    fillHeight = box_fillHeight,
                    hinge_sphere_lock_protrusion = hinge_sphere_lock
                );
            }
        }
    }
}

//===============================================
// DUMMY MEASUREMENT OBJECTS (Gap Visualization)
//===============================================
// Three dummy objects to visualize critical gaps:
// 1. Lid inner surface - shows gap to battery tops
// 2. Battery gaps - shows clearance around each battery
// 3. Spacer gap - shows clearance between spacer and wall

// 1. Lid inner surface dummy (shows where lid would be when closed)
module dummy_lid_surface() {
    if (show_dummy_objects) {
        // Calculate inner dimensions (box inner space without shell)
        inner_length = box_length - 2 * box_shell;
        inner_width = box_width - 2 * box_shell;

        // Dummy lid ALWAYS follows actual lid position/rotation via top_transform
        // Works in all view modes - lid rotates with hinge state
        color(COLOR_DUMMY, COLOR_DUMMY_TRANSP) {
            top_transform(top_part_position, hinge_state, box_length, box_shell, bottom_height, top_height) {
                // Position at lid's inner surface (box_shell in lid's local coords)
                translate([0, 0, box_shell]) {
                    cube([inner_length, inner_width, dummy_lid_thickness], center = true);
                }
            }
        }
    }
}

// 2. Battery gap dummy (simple cube showing clearance size)
module dummy_battery_gaps() {
    if (show_dummy_objects) {
        spacing = calc_battery_spacing(SELECTED_BATTERY, SELECTED_DESIGN);
        outer_wall = design_outer_wall_thickness(SELECTED_DESIGN);
        clearance = design_battery_clearance(SELECTED_DESIGN);
        bat_r = bat_max_diameter(SELECTED_BATTERY) / 2;
        holder_dims = calc_holder_dimensions(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX);

        // Position at second battery X (x=1 in matrix)
        battery_x = -holder_dims[0]/2 + outer_wall + 1 * spacing + spacing / 2;

        // Cube positioned IN the gap (battery edge + half clearance)
        gap_x = battery_x + bat_r + clearance / 2;

        // Position cube on X-axis (Y=0), with TOP edge at spacer top
        // Cube top aligns with spacer top edge
        // Cube size = actual radial gap (clearance)
        translate([gap_x, 0, actual_spacer_height - clearance/2]) {
            color(COLOR_DUMMY, COLOR_DUMMY_TRANSP) {
                cube([clearance, clearance, clearance], center = true);
            }
        }
    }
}

// 3. Spacer gap dummy (simple cube showing gap size)
module dummy_spacer_gap() {
    if (show_dummy_objects) {
        holder_dims = calc_holder_dimensions(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX);

        // Simple cube IN the gap between spacer edge and wall
        // Position at spacer edge + half gap
        spacer_edge_x = holder_dims[0] / 2;
        gap_center_x = spacer_edge_x + spacer_margin_xy / 2;

        // Position cube with TOP edge at spacer top
        // Cube top aligns with spacer top edge
        // Cube size = actual spacer margin
        translate([gap_center_x, 0, actual_spacer_height - spacer_margin_xy/2]) {
            color(COLOR_DUMMY, COLOR_DUMMY_TRANSP) {
                cube([spacer_margin_xy, spacer_margin_xy, spacer_margin_xy], center = true);
            }
        }
    }
}

// 4. Battery top gap dummy (cube showing gap from battery top to lid)
module dummy_battery_top_gap() {
    if (show_dummy_objects) {
        spacing = calc_battery_spacing(SELECTED_BATTERY, SELECTED_DESIGN);
        outer_wall = design_outer_wall_thickness(SELECTED_DESIGN);
        holder_dims = calc_holder_dimensions(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX);

        // Battery farthest from hinge (last column, middle row)
        battery_x = -holder_dims[0]/2 + outer_wall + (MATRIX[0]-1) * spacing + spacing / 2;

        // Cube ON battery top, on X-axis, showing gap to lid
        // Cube size = battery_top_clearance
        translate([battery_x, 0, bat_total_height(SELECTED_BATTERY) + battery_top_clearance/2]) {
            color(COLOR_DUMMY, COLOR_DUMMY_TRANSP) {
                cube([battery_top_clearance, battery_top_clearance, battery_top_clearance], center = true);
            }
        }
    }
}

// Separation distance for SHOW_ALL_SEPARATED mode
separation = 20;

if (view_mode == SHOW_BOX_ONLY || view_mode == SHOW_BOX_WITH_SPACER || view_mode == SHOW_ALL_SEPARATED) {
    // Render bottom part
    if (view_mode == SHOW_ALL_SEPARATED) {
        // Bottom at center for separated view
        difference() {
            set_color(COLOR_BOTTOM_BOOL, COLOR_BOTTOM, COLOR_BOTTOM_TRANSP)
            ruggedBox(
                box_length,
                box_width,
                bottom_height,
                fillet = box_fillet,
                shell = box_shell,
                rib = box_rib,
                top = false,
                clearance = box_clearance,
                fillHeight = box_fillHeight,
                hinge_sphere_lock_protrusion = hinge_sphere_lock
            );
        }
    } else {
        difference() {
            set_color(COLOR_BOTTOM_BOOL, COLOR_BOTTOM, COLOR_BOTTOM_TRANSP)
	      ruggedBox( // xxx
                box_length,
                box_width,
                bottom_height,
                fillet = box_fillet,
                shell = box_shell,
                rib = box_rib,
                top = false,
                clearance = box_clearance,
                fillHeight = box_fillHeight,
                hinge_sphere_lock_protrusion = hinge_sphere_lock
            );
        }
    }

    // Render top part
    if (view_mode == SHOW_ALL_SEPARATED) {
        translate([0, box_width + separation, 0])
        difference() {
            set_color(COLOR_TOP_BOOL, COLOR_TOP, COLOR_TOP_TRANSP)
            ruggedBox(
                box_length,
                box_width,
                top_height,
                fillet = box_fillet,
                shell = box_shell,
                rib = box_rib,
                top = true,
                clearance = box_clearance,
                fillHeight = box_fillHeight,
                hinge_sphere_lock_protrusion = hinge_sphere_lock
            );
        }
    } else {
        difference() {
            set_color(COLOR_TOP_BOOL, COLOR_TOP, COLOR_TOP_TRANSP)
            top_transform(top_part_position, hinge_state, box_length, box_shell, bottom_height, top_height)
	      ruggedBox( // xxx
                box_length,
                box_width,
                top_height,
                fillet = box_fillet,
                shell = box_shell,
                rib = box_rib,
                top = true,
                clearance = box_clearance,
                fillHeight = box_fillHeight,
                hinge_sphere_lock_protrusion = hinge_sphere_lock
            );
        }
    }

    // Show batteries for clearance checking
    if (show_batteries) {
        if (view_mode == SHOW_BOX_ONLY || view_mode == SHOW_ALL_SEPARATED) {
            // Batteries in bottom (centered, at spacer position)
            translate([0, 0, spacer_offset_z]) {
                battery_matrix(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX, COLOR_BATTERY_BOOL, COLOR_BATTERY, COLOR_BATTERY_TRANSP);
            }
        }
    }
}

if (view_mode == SHOW_BOX_BOTTOM) {
    // Only bottom - positioned for STL export
    difference() {
        ruggedBox(
            box_length,
            box_width,
            bottom_height,
            fillet = box_fillet,
            shell = box_shell,
            rib = box_rib,
            top = false,
            clearance = box_clearance,
            fillHeight = box_fillHeight,
            hinge_sphere_lock_protrusion = hinge_sphere_lock
        );
    }

    // Show batteries for clearance verification
    if (show_batteries) {
        translate([0, 0, spacer_offset_z]) {
            battery_matrix(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX, COLOR_BATTERY_BOOL, COLOR_BATTERY, COLOR_BATTERY_TRANSP);
        }
    }
}

if (view_mode == SHOW_BOX_LID) {
    // Only lid - positioned for STL export
    difference() {
        ruggedBox(
            box_length,
            box_width,
            top_height,
            fillet = box_fillet,
            shell = box_shell,
            rib = box_rib,
            top = true,
            clearance = box_clearance,
            fillHeight = box_fillHeight,
            hinge_sphere_lock_protrusion = hinge_sphere_lock
        );
    }

    // Show batteries for TOP CLEARANCE verification (CRITICAL!)
    // Position batteries to show gap between pin top and lid inner surface
    if (show_batteries) {
        // Lid inner surface at: top_height - box_shell
        // Battery tops should be: lid_inner - battery_top_clearance
        // Battery bottoms at: lid_inner - battery_top_clearance - battery_height
        translate([0, 0, (top_height - box_shell) - battery_top_clearance - bat_total_height(SELECTED_BATTERY)]) {
            battery_matrix(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX, COLOR_BATTERY_BOOL, COLOR_BATTERY, COLOR_BATTERY_TRANSP);
        }
    }
}

if (view_mode == SHOW_SPACER || view_mode == SHOW_BOX_WITH_SPACER || view_mode == SHOW_ALL_SEPARATED) {
    // Render spacer (always in bottom part, removable)
    if (view_mode == SHOW_ALL_SEPARATED) {
        // Show spacer in separated layout - at REAL Z position
        translate([0, 2 * (box_width + separation), spacer_offset_z]) {
            set_color(COLOR_SPACER_BOOL, COLOR_SPACER, COLOR_SPACER_TRANSP)
            holder_matrix(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX, actual_spacer_height, spacer_fillet);
        }
    } else if (view_mode == SHOW_SPACER) {
        // Spacer at REAL position (same as in box) for correct STL export
        translate([0, 0, spacer_offset_z]) {
            holder_matrix(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX, actual_spacer_height, spacer_fillet);

            // Show batteries if enabled (sit directly on spacer base)
            if (show_batteries) {
                battery_matrix(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX, COLOR_BATTERY_BOOL, COLOR_BATTERY, COLOR_BATTERY_TRANSP);
            }
        }
    } else {
        // Positioned inside box bottom - SHOW_BOX_WITH_SPACER mode
        translate([0, 0, spacer_offset_z]) {
	  set_color(COLOR_SPACER_BOOL, COLOR_SPACER, COLOR_SPACER_TRANSP) // xxx
            holder_matrix(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX, actual_spacer_height, spacer_fillet);

            // Show batteries if enabled (sit directly on spacer base)
            if (show_batteries) {
	      battery_matrix(SELECTED_BATTERY, SELECTED_DESIGN, MATRIX, COLOR_BATTERY_BOOL, COLOR_BATTERY, COLOR_BATTERY_TRANSP);
            }
        }
    }
}

// DUMMY MEASUREMENT OBJECTS
if (show_dummy_objects) {
    translate([0, 0, spacer_offset_z]) {
        dummy_battery_gaps();
        dummy_spacer_gap();
        dummy_battery_top_gap();
    }

    dummy_lid_surface();
}

//===============================================
// STL EXPORT & PRINTING INSTRUCTIONS
//===============================================
/*

═══════════════════════════════════════════════════════════════════
EXPORTING STL FILES
═══════════════════════════════════════════════════════════════════

STEP 1: Select export view mode (uncomment the one you want):
  //view_mode = SHOW_BOX_BOTTOM;  // For bottom half STL
  //view_mode = SHOW_BOX_LID;     // For lid STL
  //view_mode = SHOW_SPACER;      // For spacer STL

STEP 2: Render and export
  - Press F6 to render (may take 5-10 seconds)
  - Press F7 to export STL
  - Or: Menu → Design → Render → Design → Export as STL

STEP 3: Verify in slicer
  - Check that geometry is manifold (watertight)
  - Verify correct orientation (see below)

═══════════════════════════════════════════════════════════════════
PRINT ORIENTATION (Parts are pre-oriented optimally)
═══════════════════════════════════════════════════════════════════

BOX BOTTOM:
  ✓ Print as-exported (hinge side down, snap lock up)
  ✓ Minimizes supports, optimizes layer lines
  ⚠ Supports needed for hinge cylinder overhangs

BOX LID:
  ✓ Print as-exported (hinge side up, lid surface down)
  ✓ Clean lid surface, minimal supports on hinge
  ℹ Label area will be on build plate (good detail)

SPACER:
  ✓ Print as-exported (flat on build plate)
  ✓ No supports needed
  ✓ Through-holes print cleanly in this orientation

═══════════════════════════════════════════════════════════════════
RECOMMENDED PRINT SETTINGS
═══════════════════════════════════════════════════════════════════

FOR MFG_STANDARD_FDM (0.4mm nozzle):
  • Layer Height: 0.2mm
  • Perimeters/Walls: 3-4 (1.2-1.6mm total)
  • Infill: 15-20% (gyroid or grid)
  • Top/Bottom Layers: 4-5
  • Print Speed: 50-60mm/s
  • Temperature: PLA 200-210°C, PETG 235-245°C
  • Supports: Tree supports, interface enabled
  • Support Placement: "Touching buildplate" for bottom

FOR MFG_PRECISION (0.2mm nozzle):
  • Layer Height: 0.1mm
  • Perimeters/Walls: 4-5 (0.8-1.0mm total)
  • Infill: 20-25%
  • Print Speed: 30-40mm/s
  • Temperature: +5°C from standard
  • Supports: Fine supports with dense interface

FOR MFG_DRAFT (0.6mm nozzle):
  • Layer Height: 0.3mm
  • Perimeters/Walls: 3 (1.8mm total)
  • Infill: 15%
  • Print Speed: 70-80mm/s
  • Temperature: Standard settings
  • Supports: Standard tree supports

═══════════════════════════════════════════════════════════════════
ASSEMBLY NOTES
═══════════════════════════════════════════════════════════════════

1. Test fit before full assembly
   - Hinge should slide smoothly
   - Snap lock should click firmly
   - Adjust clearance if needed (box_clearance parameter)

2. Post-processing options
   - Sand snap lock area for smoother action
   - Add grease to hinge for smoother operation
   - Use acetone vapor (ABS) or heat gun (PET) for smoother finish

3. Spacer integration
   - Spacer sits in box bottom (removable design)
   - If wet: Remove spacer, dry with cloth, replace
   - Adjust spacer_height_offset to raise/lower position
   - Box remains watertight without spacer

4. Optional features (disabled by default - maintain watertight seal)
   - Drainage/Ventilation: BREAKS watertight seal
   - Enable only if specifically needed for your use case
   - Mounting holes: For permanent installation
   - Label area: Visual identification

═══════════════════════════════════════════════════════════════════
TROUBLESHOOTING
═══════════════════════════════════════════════════════════════════

Issue: Hinge too tight
  → Increase box_clearance (try 0.4 or 0.5)

Issue: Snap lock won't close
  → Check print temperature (may be over-extruding)
  → Increase clearance or sand snap mechanism

Issue: Batteries don't fit in spacer
  → Increase design_battery_clearance (try 0.4-0.5)
  → Check actual battery diameter vs spec

Issue: Box lid doesn't align
  → Verify parts printed from same config
  → Check Z-height calibration on printer

*/
