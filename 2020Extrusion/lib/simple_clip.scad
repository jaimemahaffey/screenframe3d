// =====================================================
// Simple C-Clip Tube Holder
// =====================================================
// Press-fit C-shaped clip for quick tube mounting
// Part of SCAD Toolkit - 2020Extrusion Library

include <../config.scad>
use <../../common/utils.scad>
use <profile_base.scad>

// =====================================================
// SIMPLE CLIP PARAMETERS
// =====================================================

// Clip base size
SIMPLE_CLIP_WIDTH = 38;   // 1.5" = 38.1mm
SIMPLE_CLIP_LENGTH = 38;

// C-clip parameters
C_CLIP_OPENING_ANGLE = 90;  // Degrees of opening (90 = 1/4 open)
C_CLIP_WALL = 2.5;          // Wall thickness
C_CLIP_HEIGHT = 20;         // Height of C-clip

// =====================================================
// SIMPLE C-CLIP TUBE HOLDER
// =====================================================

module simple_tube_clip(tube_od=TUBE_OD_QUARTER_INCH, base_width=SIMPLE_CLIP_WIDTH, base_length=SIMPLE_CLIP_LENGTH) {
    inner_radius = tube_od / 2 + TOLERANCE * 0.5;  // Tighter fit for press-fit
    outer_radius = inner_radius + C_CLIP_WALL;

    base_height = MOUNT_HEIGHT;  // Use standard mount height for twist-lock

    difference() {
        union() {
            // Mounting base plate (rectangular for twist-lock tabs)
            translate([-base_width/2, -outer_radius - C_CLIP_WALL/2, 0])
            rounded_cube([base_width, outer_radius + C_CLIP_WALL/2 + 5, base_height], radius=1);

            // Twist-lock tabs (male connectors)
            translate([-LOCK_TAB_WIDTH/2, -outer_radius - C_CLIP_WALL/2, T_SLOT_DEPTH])
            twist_lock_tabs();

            translate([LOCK_TAB_WIDTH/2, -outer_radius - C_CLIP_WALL/2, T_SLOT_DEPTH])
            mirror([1, 0, 0])
            twist_lock_tabs();

            // C-shaped clip body
            translate([0, 0, base_height])
            difference() {
                // Outer cylinder
                cylinder(r=outer_radius, h=C_CLIP_HEIGHT, $fn=60);

                // Inner tube space
                translate([0, 0, -0.1])
                cylinder(r=inner_radius, h=C_CLIP_HEIGHT + 0.2, $fn=60);

                // Opening for press-fit insertion
                opening_width = outer_radius * 2 + 2;
                rotate([0, 0, -C_CLIP_OPENING_ANGLE/2])
                translate([-opening_width/2, 0, -0.1])
                cube([opening_width, outer_radius + 1, C_CLIP_HEIGHT + 0.2]);
            }

            // Entry chamfer/flare for easier tube insertion
            translate([0, 0, base_height + C_CLIP_HEIGHT])
            difference() {
                cylinder(r1=outer_radius, r2=outer_radius + 1, h=1.5, $fn=60);
                translate([0, 0, -0.1])
                cylinder(r1=inner_radius, r2=inner_radius + 0.5, h=1.6, $fn=60);

                // Match opening
                opening_width = outer_radius * 2 + 4;
                rotate([0, 0, -C_CLIP_OPENING_ANGLE/2])
                translate([-opening_width/2, 0, -0.1])
                cube([opening_width, outer_radius + 2, 2]);
            }
        }

        // T-slot insert space (for twist-lock mechanism)
        translate([-t_slot_insert_width()/2, -outer_radius - C_CLIP_WALL/2 - 0.1, T_SLOT_DEPTH])
        cube([t_slot_insert_width(), T_SLOT_DEPTH + 1, base_height - T_SLOT_DEPTH + 0.1]);

        // Twist-lock channels on sides
        translate([-LOCK_TAB_WIDTH/2 - 2, -outer_radius - C_CLIP_WALL/2 - 0.1, T_SLOT_DEPTH - 1])
        rotate([0, 0, 0])
        twist_lock_channel();

        translate([LOCK_TAB_WIDTH/2 + 2, -outer_radius - C_CLIP_WALL/2 - 0.1, T_SLOT_DEPTH - 1])
        mirror([1, 0, 0])
        twist_lock_channel();
    }

    // Add grip ribs on inside of C-clip for better hold
    translate([0, 0, base_height]) {
        for (angle = [C_CLIP_OPENING_ANGLE/2 + 20 : 40 : 360 - C_CLIP_OPENING_ANGLE/2 - 20]) {
            rotate([0, 0, angle])
            translate([inner_radius - 0.3, -0.4, 0])
            cube([0.3, 0.8, C_CLIP_HEIGHT]);
        }
    }
}

// Twist-lock tabs (imported from tube_clips.scad pattern)
module twist_lock_tabs() {
    tab_height = 4;
    tab_base_width = LOCK_TAB_WIDTH;

    // Main tab body
    linear_extrude(LOCK_TAB_THICKNESS)
    polygon([
        [0, 0],
        [tab_base_width, 0],
        [tab_base_width - 2, tab_height],
        [2, tab_height]
    ]);

    // Entry bevel for easier insertion
    translate([0, -0.5, 0])
    rotate([-90, 0, 0])
    linear_extrude(0.5)
    polygon([
        [0, 0],
        [tab_base_width, 0],
        [tab_base_width, LOCK_TAB_THICKNESS],
        [0, LOCK_TAB_THICKNESS]
    ]);
}

// Lock channel (the receiving slot for twist lock)
module twist_lock_channel(length=LOCK_TAB_WIDTH + 4, width=LOCK_TAB_THICKNESS + 0.4, depth=5) {
    translate([0, 0, -0.1])
    union() {
        // Straight insertion channel
        cube([length/2, width, depth + 0.1]);

        // Rotated lock channel
        translate([length/2, width/2, 0])
        rotate([0, 0, LOCK_ROTATION])
        translate([-length/4, -width/2, 0])
        cube([length/2, width, depth + 0.1]);
    }
}

// =====================================================
// USAGE EXAMPLE
// =====================================================

// Example: Simple clip with tube
/*
simple_tube_clip(tube_od=TUBE_OD_QUARTER_INCH);

// Simulated tube
color("DodgerBlue")
translate([0, 0, 8 + 10])
cylinder(d=TUBE_OD_QUARTER_INCH, h=30, $fn=30);
*/

// Example: With profile reference
/*
translate([0, 40, 0])
    color("Silver", alpha=0.5)
    profile_2020(length=100);

simple_tube_clip();
*/

echo("Simple C-Clip Tube Holder loaded");
echo(str("Base size: ", SIMPLE_CLIP_WIDTH, " x ", SIMPLE_CLIP_LENGTH, "mm"));
echo(str("Mounting: Two M4 screws into T-slot"));
