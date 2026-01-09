// =====================================================
// 2020 Profile Base Module
// =====================================================
// Reference model of 2020 aluminum extrusion profile
// Use for mock-ups and fit testing
// Part of SCAD Toolkit - IN DEVELOPMENT

include <../config.scad>

// =====================================================
// 2020 PROFILE REFERENCE MODEL
// =====================================================

// Creates a reference model of 2020 aluminum profile
// Parameters:
//   length: Profile length in mm
//   show_center_hole: Whether to show center mounting hole
module profile_2020(length=100, show_center_hole=true) {
    difference() {
        // Main square profile
        cube([PROFILE_WIDTH, PROFILE_HEIGHT, length]);

        // T-slots on all four sides
        for (angle = [0:90:270]) {
            rotate([0, 0, angle])
            translate([PROFILE_WIDTH/2 - T_SLOT_DEPTH, -T_SLOT_WIDTH/2, -0.1])
            t_slot_negative(length + 0.2);
        }

        // Center hole (optional)
        if (show_center_hole) {
            translate([PROFILE_WIDTH/2, PROFILE_HEIGHT/2, -0.1])
            cylinder(d=CENTER_HOLE_DIA, h=length + 0.2, $fn=30);
        }
    }
}

// T-slot negative space (for subtracting from profile)
module t_slot_negative(length) {
    // Slot opening
    cube([T_SLOT_DEPTH, T_SLOT_WIDTH, length]);

    // T-slot head (internal cavity)
    translate([T_SLOT_DEPTH - (T_SLOT_HEAD - T_SLOT_WIDTH)/2, -T_SLOT_HEAD/2 + T_SLOT_WIDTH/2, 0])
    cube([T_SLOT_HEAD - T_SLOT_WIDTH, T_SLOT_HEAD, length]);
}

// =====================================================
// T-SLOT INSERT (POSITIVE)
// =====================================================

// Creates a T-slot compatible insert
// Use this to create parts that fit into T-slots
module t_slot_insert(length=10, head_length=0) {
    actual_head_length = (head_length > 0) ? head_length : length;

    // Neck (slides into slot opening)
    translate([0, -t_slot_neck_width()/2, 0])
    cube([T_SLOT_DEPTH - TOLERANCE, t_slot_neck_width(), length]);

    // Head (locks into T-slot)
    translate([0, -t_slot_insert_width()/2, 0])
    cube([T_SLOT_DEPTH - (T_SLOT_HEAD - T_SLOT_WIDTH)/2 - TOLERANCE,
          t_slot_insert_width(),
          actual_head_length]);
}

// =====================================================
// SPRING NUT (T-SLOT COMPATIBLE)
// =====================================================

// Simplified spring nut for T-slot mounting
module spring_nut_simplified(thickness=3, width=12) {
    difference() {
        union() {
            // Main body
            translate([0, -width/2, 0])
            cube([T_SLOT_DEPTH - TOLERANCE, width, thickness]);

            // T-slot head
            translate([0, -t_slot_insert_width()/2, 0])
            cube([T_SLOT_DEPTH - (T_SLOT_HEAD - T_SLOT_WIDTH)/2 - TOLERANCE,
                  t_slot_insert_width(),
                  thickness]);
        }

        // Screw hole
        translate([T_SLOT_DEPTH/2, 0, -0.1])
        cylinder(d=4.5, h=thickness + 0.2, $fn=30);  // M4 clearance
    }
}

// =====================================================
// USAGE EXAMPLES (commented out)
// =====================================================

// Example: Show 2020 profile
/*
profile_2020(length=100);
*/

// Example: T-slot insert
/*
translate([30, 10, 0])
    rotate([0, 0, -90])
    t_slot_insert(length=15);
*/

// Example: Spring nut
/*
translate([30, 10, 20])
    rotate([0, 0, -90])
    spring_nut_simplified();
*/

echo("2020 Profile Base Module loaded");
echo("Use profile_2020() for reference models");
echo("Use t_slot_insert() for T-slot compatible parts");
