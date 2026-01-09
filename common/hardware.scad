// =====================================================
// Common Hardware Library
// =====================================================
// Standard hardware components (screws, nuts, bolts, washers)
// Useful for creating negative space or mock-ups
// Part of SCAD Toolkit

// All dimensions in millimeters

// =====================================================
// METRIC SCREWS
// =====================================================

// ISO 7380 Button Head Screw (common for 3D printing)
module button_head_screw(diameter=3, length=10, head_diameter=0, head_height=0) {
    // Auto-calculate head dimensions if not specified
    actual_head_diameter = (head_diameter > 0) ? head_diameter : diameter * 2;
    actual_head_height = (head_height > 0) ? head_height : diameter * 0.65;

    // Shaft
    cylinder(d=diameter, h=length, $fn=30);

    // Button head
    translate([0, 0, -actual_head_height])
    intersection() {
        sphere(d=actual_head_diameter, $fn=50);
        cylinder(d=actual_head_diameter + 1, h=actual_head_height + 0.1, $fn=50);
    }
}

// ISO 10642 Countersunk Screw
module countersunk_screw(diameter=3, length=10, head_diameter=0, head_height=0) {
    // Auto-calculate dimensions
    actual_head_diameter = (head_diameter > 0) ? head_diameter : diameter * 2;
    actual_head_height = (head_height > 0) ? head_height : diameter * 0.6;

    // Shaft
    cylinder(d=diameter, h=length, $fn=30);

    // Countersunk head
    translate([0, 0, -actual_head_height])
    cylinder(d1=actual_head_diameter, d2=diameter, h=actual_head_height, $fn=30);
}

// ISO 4762 Socket Head Cap Screw
module socket_head_screw(diameter=3, length=10, head_diameter=0, head_height=0) {
    actual_head_diameter = (head_diameter > 0) ? head_diameter : diameter * 1.5;
    actual_head_height = (head_height > 0) ? head_height : diameter;

    // Shaft
    cylinder(d=diameter, h=length, $fn=30);

    // Socket head
    translate([0, 0, -actual_head_height])
    cylinder(d=actual_head_diameter, h=actual_head_height, $fn=30);
}

// Generic screw hole (clearance hole)
module screw_hole(diameter=3.2, length=20, countersink=false, countersink_diameter=6.5, countersink_depth=2) {
    cylinder(d=diameter, h=length, $fn=30);

    if (countersink) {
        translate([0, 0, length - countersink_depth])
        cylinder(d=countersink_diameter, h=countersink_depth + 0.1, $fn=30);
    }
}

// =====================================================
// METRIC NUTS
// =====================================================

// ISO 4032 Hex Nut
module hex_nut(diameter=3, height=0, flat_to_flat=0) {
    // Auto-calculate dimensions
    actual_height = (height > 0) ? height : diameter * 0.8;
    actual_ftf = (flat_to_flat > 0) ? flat_to_flat : diameter * 2;

    cylinder(d=actual_ftf / cos(30), h=actual_height, $fn=6);
}

// Square nut (less common, but useful)
module square_nut(diameter=3, height=0, width=0) {
    actual_height = (height > 0) ? height : diameter * 0.8;
    actual_width = (width > 0) ? width : diameter * 2;

    translate([-actual_width/2, -actual_width/2, 0])
    difference() {
        cube([actual_width, actual_width, actual_height]);
        translate([actual_width/2, actual_width/2, -0.1])
        cylinder(d=diameter, h=actual_height + 0.2, $fn=30);
    }
}

// Hex nut pocket (cutout for press-fit or capture)
module hex_nut_pocket(diameter=3, height=0, flat_to_flat=0, tolerance=0.2) {
    actual_height = (height > 0) ? height : diameter * 0.8;
    actual_ftf = (flat_to_flat > 0) ? flat_to_flat : diameter * 2;

    cylinder(d=(actual_ftf + tolerance) / cos(30), h=actual_height + 0.1, $fn=6);
}

// =====================================================
// WASHERS
// =====================================================

// Flat washer
module washer(inner_diameter=3.2, outer_diameter=7, thickness=0.5) {
    difference() {
        cylinder(d=outer_diameter, h=thickness, $fn=50);
        translate([0, 0, -0.1])
        cylinder(d=inner_diameter, h=thickness + 0.2, $fn=30);
    }
}

// =====================================================
// THREADED INSERTS
// =====================================================

// Heat-set threaded insert (e.g., Voron M3x5x4)
module heat_set_insert(thread_diameter=3, outer_diameter=4, length=5, tolerance=0.1) {
    cylinder(d=outer_diameter + tolerance, h=length, $fn=30);
}

// Insert pocket (pilot hole for heat-set insert)
module insert_pocket(thread_diameter=3, outer_diameter=4, length=5, tolerance=0.1) {
    translate([0, 0, -0.1])
    cylinder(d=outer_diameter + tolerance, h=length + 0.1, $fn=30);
}

// =====================================================
// COMMON METRIC SIZES
// =====================================================

// M2 Screw
module M2_screw(length=10, type="button") {
    if (type == "button") button_head_screw(2, length, 4, 1.3);
    else if (type == "countersunk") countersunk_screw(2, length, 4, 1.2);
    else socket_head_screw(2, length, 3.8, 2);
}

// M3 Screw (most common in 3D printing)
module M3_screw(length=10, type="button") {
    if (type == "button") button_head_screw(3, length, 5.7, 1.95);
    else if (type == "countersunk") countersunk_screw(3, length, 6, 1.8);
    else socket_head_screw(3, length, 5.5, 3);
}

// M4 Screw
module M4_screw(length=10, type="button") {
    if (type == "button") button_head_screw(4, length, 7.6, 2.6);
    else if (type == "countersunk") countersunk_screw(4, length, 8, 2.4);
    else socket_head_screw(4, length, 7, 4);
}

// M5 Screw
module M5_screw(length=10, type="button") {
    if (type == "button") button_head_screw(5, length, 9.5, 3.25);
    else if (type == "countersunk") countersunk_screw(5, length, 10, 3);
    else socket_head_screw(5, length, 8.5, 5);
}

// M3 Hex Nut
module M3_hex_nut() {
    hex_nut(diameter=3, height=2.4, flat_to_flat=5.5);
}

// M4 Hex Nut
module M4_hex_nut() {
    hex_nut(diameter=4, height=3.2, flat_to_flat=7);
}

// M5 Hex Nut
module M5_hex_nut() {
    hex_nut(diameter=5, height=4, flat_to_flat=8);
}

// =====================================================
// USAGE EXAMPLES (commented out)
// =====================================================

// Example: M3 button head screw and nut
/*
M3_screw(length=15, type="button");
translate([0, 0, -5])
    M3_hex_nut();
*/

// Example: Screw hole with countersink
/*
screw_hole(diameter=3.2, length=10, countersink=true, countersink_diameter=6.5, countersink_depth=2);
*/

// Example: Heat-set insert pocket
/*
insert_pocket(thread_diameter=3, outer_diameter=4, length=5);
*/
