// =====================================================
// Common Utility Functions
// =====================================================
// Helper functions and modules for OpenSCAD projects
// Part of SCAD Toolkit

// =====================================================
// UNIT CONVERSIONS
// =====================================================

// Convert inches to millimeters
function inch(inches) = inches * 25.4;

// Convert millimeters to inches
function mm_to_inch(mm) = mm / 25.4;

// Convert feet to millimeters
function feet(ft) = ft * 304.8;

// =====================================================
// CHAMFERS AND FILLETS
// =====================================================

// Chamfer a corner (45 degree)
module chamfer(size=1, length=10) {
    rotate([0, 0, 45])
    cube([size * sqrt(2), size * sqrt(2), length], center=true);
}

// Fillet a corner (rounded)
module fillet(radius=2, length=10) {
    difference() {
        translate([-radius, -radius, 0])
        cube([radius, radius, length]);

        translate([0, 0, -0.1])
        cylinder(r=radius, h=length + 0.2, $fn=50);
    }
}

// External fillet (convex corner)
module external_fillet(radius=2, length=10) {
    intersection() {
        cylinder(r=radius, h=length, $fn=50);
        cube([radius, radius, length]);
    }
}

// =====================================================
// ROUNDING AND SMOOTHING
// =====================================================

// Round all corners of a 2D shape
module rounded_square(size=[10, 10], radius=2) {
    offset(r=radius, $fn=50)
    offset(r=-radius)
    square(size, center=true);
}

// Rounded cube
module rounded_cube(size=[10, 10, 10], radius=2) {
    hull() {
        translate([radius, radius, radius])
        sphere(r=radius, $fn=30);

        translate([size[0]-radius, radius, radius])
        sphere(r=radius, $fn=30);

        translate([radius, size[1]-radius, radius])
        sphere(r=radius, $fn=30);

        translate([size[0]-radius, size[1]-radius, radius])
        sphere(r=radius, $fn=30);

        translate([radius, radius, size[2]-radius])
        sphere(r=radius, $fn=30);

        translate([size[0]-radius, radius, size[2]-radius])
        sphere(r=radius, $fn=30);

        translate([radius, size[1]-radius, size[2]-radius])
        sphere(r=radius, $fn=30);

        translate([size[0]-radius, size[1]-radius, size[2]-radius])
        sphere(r=radius, $fn=30);
    }
}

// =====================================================
// PATTERNS AND ARRAYS
// =====================================================

// Linear array (1D)
module linear_array(count=5, spacing=10) {
    for (i = [0:count-1]) {
        translate([i * spacing, 0, 0])
        children();
    }
}

// Grid array (2D)
module grid_array(rows=3, cols=3, spacing=[10, 10]) {
    for (x = [0:cols-1]) {
        for (y = [0:rows-1]) {
            translate([x * spacing[0], y * spacing[1], 0])
            children();
        }
    }
}

// Circular array (radial pattern)
module circular_array(count=6, radius=20) {
    for (i = [0:count-1]) {
        angle = i * 360 / count;
        rotate([0, 0, angle])
        translate([radius, 0, 0])
        children();
    }
}

// Honeycomb pattern
module honeycomb_pattern(rows=5, cols=5, diameter=10, wall=2) {
    hex_spacing_x = diameter * 3/4;
    hex_spacing_y = diameter * sqrt(3)/2;

    difference() {
        children();

        for (x = [0:cols-1]) {
            for (y = [0:rows-1]) {
                offset_x = (y % 2) * diameter * 3/8;
                translate([x * hex_spacing_x + offset_x, y * hex_spacing_y, -0.1])
                cylinder(d=diameter - wall, h=100, $fn=6);
            }
        }
    }
}

// =====================================================
// TEXT AND LABELS
// =====================================================

// Embossed text (raised)
module embossed_text(text_string, size=10, height=1, font="Liberation Sans:style=Bold") {
    linear_extrude(height)
    text(text_string, size=size, font=font, halign="center", valign="center");
}

// Debossed text (engraved)
module debossed_text(text_string, size=10, depth=1, font="Liberation Sans:style=Bold") {
    translate([0, 0, -depth])
    linear_extrude(depth + 0.1)
    text(text_string, size=size, font=font, halign="center", valign="center");
}

// Braille dots (for accessibility)
module braille_dot(diameter=1.5, height=0.5) {
    cylinder(d=diameter, h=height, $fn=20);
}

// =====================================================
// CLEARANCES AND TOLERANCES
// =====================================================

// Calculate clearance for press fit
function press_fit_clearance(nominal_size, material="PLA") =
    material == "PLA" ? nominal_size * 0.005 :
    material == "PETG" ? nominal_size * 0.007 :
    material == "ABS" ? nominal_size * 0.008 :
    nominal_size * 0.006; // Default

// Calculate clearance for sliding fit
function sliding_fit_clearance(nominal_size) = nominal_size * 0.02;

// Calculate clearance for loose fit
function loose_fit_clearance(nominal_size) = nominal_size * 0.05;

// =====================================================
// GEOMETRY HELPERS
// =====================================================

// Truncated cone (frustum)
module frustum(bottom_diameter, top_diameter, height) {
    cylinder(d1=bottom_diameter, d2=top_diameter, h=height, $fn=50);
}

// Capsule (cylinder with hemispherical ends)
module capsule(diameter, length) {
    hull() {
        sphere(d=diameter, $fn=50);
        translate([0, 0, length])
        sphere(d=diameter, $fn=50);
    }
}

// Torus (donut shape)
module torus(major_radius=10, minor_radius=2) {
    rotate_extrude($fn=100)
    translate([major_radius, 0, 0])
    circle(r=minor_radius, $fn=50);
}

// =====================================================
// PRINT-IN-PLACE HELPERS
// =====================================================

// Living hinge (parametric)
module living_hinge(width=20, length=50, thickness=1, gap=0.5, segments=10) {
    segment_width = length / segments;

    for (i = [0:segments-1]) {
        if (i % 2 == 0) {
            translate([0, i * segment_width, 0])
            cube([width, segment_width - gap, thickness]);
        }
    }
}

// Print-in-place chain link
module chain_link(length=20, width=8, thickness=3, gap=0.5) {
    difference() {
        hull() {
            cylinder(d=width, h=thickness, $fn=30);
            translate([length, 0, 0])
            cylinder(d=width, h=thickness, $fn=30);
        }

        // Inner cutout
        translate([0, 0, -0.1])
        hull() {
            cylinder(d=width - thickness*2, h=thickness + 0.2, $fn=30);
            translate([length, 0, 0])
            cylinder(d=width - thickness*2, h=thickness + 0.2, $fn=30);
        }
    }
}

// =====================================================
// STRUCTURAL HELPERS
// =====================================================

// Lattice infill (for large flat areas)
module lattice_infill(width, height, thickness, spacing=5, wall_thickness=1) {
    difference() {
        cube([width, height, thickness]);

        // Diagonal crosses
        for (x = [0:spacing:width]) {
            for (y = [0:spacing:height]) {
                translate([x, y, -0.1])
                rotate([0, 0, 45])
                cube([wall_thickness, spacing * sqrt(2), thickness + 0.2], center=true);

                translate([x, y, -0.1])
                rotate([0, 0, -45])
                cube([wall_thickness, spacing * sqrt(2), thickness + 0.2], center=true);
            }
        }
    }
}

// Ribbing for strength
module ribs(length=50, height=10, thickness=2, count=5) {
    spacing = length / (count - 1);

    for (i = [0:count-1]) {
        translate([i * spacing - thickness/2, 0, 0])
        cube([thickness, height, height]);
    }
}

// =====================================================
// USAGE EXAMPLES (commented out)
// =====================================================

// Example: Rounded cube
/*
rounded_cube(size=[20, 30, 5], radius=2);
*/

// Example: Grid of cylinders
/*
grid_array(rows=3, cols=4, spacing=[10, 10])
    cylinder(d=5, h=10, $fn=30);
*/

// Example: Circular array
/*
circular_array(count=8, radius=30)
    cube([5, 5, 10]);
*/

// Example: Embossed text
/*
cube([50, 20, 3]);
translate([25, 10, 3])
    embossed_text("HELLO", size=8, height=1);
*/
