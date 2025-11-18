//===============================================
// BATTERY HOLDER LIBRARY
// Modular library for 18650 battery holders/spacers
// Rust-style enum-like structures for type safety
//===============================================

//===============================================
// BATTERY SPEC STRUCTURE
//===============================================
// [0] = body_diameter (mm)
// [1] = body_height (mm)
// [2] = top_pin_diameter (mm)
// [3] = top_pin_height (mm)
// [4] = has_button_top (bool: 1=yes, 0=no)
// [5] = name (string)
// [6] = color (string for visualization)
//===============================================

function bat_body_diameter(spec)    = spec[0];
function bat_body_height(spec)      = spec[1];
function bat_top_pin_diameter(spec) = spec[2];
function bat_top_pin_height(spec)   = spec[3];
function bat_has_button_top(spec)   = spec[4];
function bat_name(spec)             = spec[5];
function bat_color(spec)            = spec[6];

function bat_total_height(spec) = bat_body_height(spec) + bat_top_pin_height(spec);
function bat_max_diameter(spec) = max(bat_body_diameter(spec), bat_top_pin_diameter(spec));

//===============================================
// MANUFACTURING/PRINTER SPEC STRUCTURE
//===============================================
// [0] = nozzle_diameter (mm)
// [1] = min_wall_thickness (mm) - minimum printable wall
// [2] = layer_height (mm)
// [3] = horizontal_clearance (mm) - XY tolerance
// [4] = vertical_clearance (mm) - Z tolerance
// [5] = name (string)
//===============================================

function mfg_nozzle_diameter(spec)      = spec[0];
function mfg_min_wall_thickness(spec)   = spec[1];
function mfg_layer_height(spec)         = spec[2];
function mfg_horizontal_clearance(spec) = spec[3];
function mfg_vertical_clearance(spec)   = spec[4];
function mfg_name(spec)                 = spec[5];

//===============================================
// HOLDER DESIGN SPEC STRUCTURE
//===============================================
// [0] = wall_thickness (mm) - holder wall around battery
// [1] = wall_between (mm) - wall between batteries
// [2] = bottom_thickness (mm)
// [3] = top_rim_height (mm) - extra rim above battery
// [4] = outer_wall_thickness (mm) - outer perimeter
// [5] = battery_clearance (mm) - radial clearance for battery
//===============================================

function design_wall_thickness(spec)       = spec[0];
function design_wall_between(spec)         = spec[1];
function design_bottom_thickness(spec)     = spec[2];
function design_top_rim_height(spec)       = spec[3];
function design_outer_wall_thickness(spec) = spec[4];
function design_battery_clearance(spec)    = spec[5];

//===============================================
// BATTERY DEFINITIONS
//===============================================

BATTERY_RED = [
    18.3, 65.2, 0, 0, 0, "red", "red"
];

BATTERY_GREEN = [
    18.4, 65.1, 0, 0, 0, "green", "green"
];

BATTERY_FENIX_BLACK = [
    18.6, 69.0, 5.5, 1.5, 1, "fenix_black", "black"
];

BATTERY_FENIX_ORANGE = [
    18.6, 68.6, 5.5, 1.5, 1, "fenix_orange", "orange"
];

BATTERY_FENIX_USB_C = [
    18.6, 71.4, 5.5, 1.8, 1, "usb_c", "blue"
];

ALL_BATTERIES = [
    BATTERY_RED,
    BATTERY_GREEN,
    BATTERY_FENIX_BLACK,
    BATTERY_FENIX_ORANGE,
    BATTERY_FENIX_USB_C
];

//===============================================
// MANUFACTURING SPECS (3D Printer Profiles)
//===============================================

// Standard FDM printer - 0.4mm nozzle
MFG_STANDARD_FDM = [
    0.4,   // nozzle_diameter
    1.2,   // min_wall_thickness (3 perimeters)
    0.2,   // layer_height
    0.2,   // horizontal_clearance
    0.1,   // vertical_clearance
    "Standard_FDM_0.4mm"
];

// High precision - 0.2mm nozzle
MFG_PRECISION = [
    0.2,
    0.8,
    0.1,
    0.15,
    0.05,
    "Precision_0.2mm"
];

// Fast draft - 0.6mm nozzle
MFG_DRAFT = [
    0.6,
    1.8,
    0.3,
    0.3,
    0.15,
    "Draft_0.6mm"
];

//===============================================
// HOLDER DESIGN PRESETS
//===============================================

// Compact design - minimal material
DESIGN_COMPACT = [
    1.6,   // wall_thickness (4 perimeters @ 0.4mm)
    1.2,   // wall_between (3 perimeters)
    2.0,   // bottom_thickness
    2.0,   // top_rim_height
    2.0,   // outer_wall_thickness
    0.3    // battery_clearance
];

// Robust design - stronger walls
DESIGN_ROBUST = [
    2.4,   // wall_thickness (6 perimeters)
    2.0,   // wall_between
    3.0,   // bottom_thickness
    3.0,   // top_rim_height
    3.0,   // outer_wall_thickness
    0.3    // battery_clearance
];

// Tight fit design
DESIGN_TIGHT = [
    2.0,
    1.6,
    2.5,
    2.5,
    2.5,
    0.2    // tighter clearance
];

//===============================================
// DIMENSION CALCULATIONS
//===============================================

// Calculate spacing between battery centers
function calc_battery_spacing(battery_spec, design_spec) =
    bat_max_diameter(battery_spec) +
    design_battery_clearance(design_spec) * 2 +
    design_wall_between(design_spec);

// Calculate single cell outer diameter
function calc_cell_outer_diameter(battery_spec, design_spec) =
    bat_max_diameter(battery_spec) +
    design_battery_clearance(design_spec) * 2 +
    design_wall_thickness(design_spec) * 2;

// Calculate total holder dimensions [width, depth, height]
function calc_holder_dimensions(battery_spec, design_spec, matrix) = [
    // Width (X)
    matrix[0] * calc_battery_spacing(battery_spec, design_spec)
    - design_wall_between(design_spec)
    + design_outer_wall_thickness(design_spec) * 2,

    // Depth (Y)
    matrix[1] * calc_battery_spacing(battery_spec, design_spec)
    - design_wall_between(design_spec)
    + design_outer_wall_thickness(design_spec) * 2,

    // Height (Z)
    design_bottom_thickness(design_spec)
    + bat_total_height(battery_spec)
    + design_top_rim_height(design_spec)
];

//===============================================
// VISUALIZATION MODULES
//===============================================

// Single battery visualization
module battery(spec) {
    body_d = bat_body_diameter(spec);
    body_h = bat_body_height(spec);
    pin_d = bat_top_pin_diameter(spec);
    pin_h = bat_top_pin_height(spec);
    has_button = bat_has_button_top(spec);

    color(bat_color(spec), alpha=0.7) {
        cylinder(d = body_d, h = body_h);

        if (has_button == 1 && pin_h > 0) {
            translate([0, 0, body_h])
            cylinder(d = pin_d, h = pin_h);
        }
    }
}

// Battery matrix visualization
module battery_matrix(battery_spec, design_spec, matrix) {
    spacing = calc_battery_spacing(battery_spec, design_spec);
    outer_wall = design_outer_wall_thickness(design_spec);
    bottom = design_bottom_thickness(design_spec);

    for (x = [0 : matrix[0] - 1]) {
        for (y = [0 : matrix[1] - 1]) {
            translate([
                outer_wall + x * spacing + spacing / 2,
                outer_wall + y * spacing + spacing / 2,
                bottom
            ])
            battery(battery_spec);
        }
    }
}

//===============================================
// HOLDER GENERATION MODULES
//===============================================

// Single battery cavity (negative space)
module battery_cavity(battery_spec, design_spec) {
    body_d = bat_body_diameter(battery_spec);
    body_h = bat_body_height(battery_spec);
    pin_d = bat_top_pin_diameter(battery_spec);
    pin_h = bat_top_pin_height(battery_spec);
    clearance = design_battery_clearance(design_spec);

    // Main body cavity
    cylinder(d = body_d + clearance * 2, h = body_h + 5);

    // Pin cavity
    if (bat_has_button_top(battery_spec) == 1 && pin_h > 0) {
        translate([0, 0, body_h])
        cylinder(d = pin_d + clearance * 2, h = pin_h + 5);
    }
}

// Single cell holder
module single_cell_holder(battery_spec, design_spec) {
    cell_outer_d = calc_cell_outer_diameter(battery_spec, design_spec);
    total_h = bat_total_height(battery_spec);
    bottom = design_bottom_thickness(design_spec);
    rim = design_top_rim_height(design_spec);

    difference() {
        // Outer cylinder
        cylinder(d = cell_outer_d, h = bottom + total_h + rim);

        // Battery cavity
        translate([0, 0, bottom])
        battery_cavity(battery_spec, design_spec);
    }
}

// Matrix holder with through-holes (spacer/organizer)
// custom_height: 0 = use calculated height, >0 = use custom height (for test prints)
module holder_matrix(battery_spec, design_spec, matrix, custom_height = 0) {
    dims = calc_holder_dimensions(battery_spec, design_spec, matrix);
    spacing = calc_battery_spacing(battery_spec, design_spec);
    outer_wall = design_outer_wall_thickness(design_spec);
    clearance = design_battery_clearance(design_spec);

    // Use custom height if specified, otherwise use calculated
    actual_height = custom_height > 0 ? custom_height : dims[2];

    // Main diameter for through-hole
    bat_d = bat_max_diameter(battery_spec);

    difference() {
        // Outer box/frame
        cube([dims[0], dims[1], actual_height]);

        // UNION all battery through-holes together
        union() {
            for (x = [0 : matrix[0] - 1]) {
                for (y = [0 : matrix[1] - 1]) {
                    translate([
                        outer_wall + x * spacing + spacing / 2,
                        outer_wall + y * spacing + spacing / 2,
                        -1  // Start below bottom, go through top
                    ])
                    // Through-hole cylinder (goes all the way through)
                    cylinder(
                        d = bat_d + clearance * 2,
                        h = actual_height + 2  // Extra height to ensure clean cut
                    );
                }
            }
        }
    }
}

//===============================================
// INFORMATION / DEBUG
//===============================================

module print_holder_info(battery_spec, design_spec, matrix) {
    dims = calc_holder_dimensions(battery_spec, design_spec, matrix);
    spacing = calc_battery_spacing(battery_spec, design_spec);

    echo("=== BATTERY HOLDER SPECIFICATIONS ===");
    echo(str("Battery: ", bat_name(battery_spec)));
    echo(str("Matrix: ", matrix[0], " x ", matrix[1], " = ", matrix[0] * matrix[1], " cells"));
    echo(str("Battery spacing: ", spacing, "mm"));
    echo(str("Holder dimensions: ", dims[0], " x ", dims[1], " x ", dims[2], "mm"));
    echo(str("Total cells: ", matrix[0] * matrix[1]));
    echo(str("Design: Wall=", design_wall_thickness(design_spec),
             "mm, Between=", design_wall_between(design_spec),
             "mm, Clearance=", design_battery_clearance(design_spec), "mm"));
}

// Visual dimension helper
module show_dimensions(battery_spec, design_spec, matrix) {
    dims = calc_holder_dimensions(battery_spec, design_spec, matrix);

    color("red", alpha=0.3)
    translate([0, 0, -0.5])
    cube([dims[0], dims[1], 0.5]);

    // Dimension annotations
    color("blue") {
        // Width
        translate([dims[0]/2, -5, 0])
        text(str(dims[0], "mm"), size=3, halign="center");

        // Depth
        translate([-5, dims[1]/2, 0])
        rotate([0, 0, 90])
        text(str(dims[1], "mm"), size=3, halign="center");

        // Height
        translate([-5, -5, dims[2]/2])
        rotate([90, 0, 90])
        text(str(dims[2], "mm"), size=3, halign="center");
    }
}
