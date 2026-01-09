// =====================================================
// Tube Clip Library - Twist-Lock Design
// =====================================================
// Twist-lock clips for securing tubing to 2020 extrusion
// Part of SCAD Toolkit - 2020Extrusion Library

include <../config.scad>
use <../../common/utils.scad>
use <profile_base.scad>

// =====================================================
// TUBE CLIP PARAMETERS
// =====================================================

// Tube dimensions
TUBE_OD_QUARTER_INCH = 6.35;  // 1/4" OD in mm

// Clip parameters
CLIP_WALL = 2.0;              // Wall thickness around tube
CLIP_WRAP_ANGLE = 270;        // Degrees of wrap (270 = 3/4 circle)
CLIP_GAP = 0.5;               // Gap for insertion flexibility

// Twist-lock parameters
LOCK_TAB_WIDTH = 8;           // Width of locking tab
LOCK_TAB_THICKNESS = 2;       // Thickness of tab
LOCK_ROTATION = 45;           // Degrees to rotate to lock

// Mount parameters
MOUNT_HEIGHT = 15;            // Height of mount base
MOUNT_WIDTH = 20;             // Width of mount base

// =====================================================
// BASE TUBE CLIP MODULE
// =====================================================

// Creates a basic tube clip body
// Parameters:
//   tube_od: Outer diameter of tube
//   wrap_angle: How far the clip wraps around tube (degrees)
//   height: Height of the clip
//   wall: Wall thickness
module tube_clip_body(tube_od=TUBE_OD_QUARTER_INCH, wrap_angle=CLIP_WRAP_ANGLE, height=15, wall=CLIP_WALL) {
    inner_radius = tube_od / 2 + TOLERANCE;
    outer_radius = inner_radius + wall;

    difference() {
        // Outer cylinder (clip body)
        rotate_extrude(angle=wrap_angle, $fn=60)
        translate([inner_radius, 0])
        square([wall, height]);

        // Entry chamfer for easy tube insertion
        translate([0, 0, height - 1])
        rotate_extrude(angle=wrap_angle, $fn=60)
        translate([inner_radius, 0])
        polygon([
            [0, 0],
            [wall, 0],
            [wall, 1],
            [wall * 0.3, 1]
        ]);
    }

    // Reinforcement ribs
    for (angle = [wrap_angle * 0.25, wrap_angle * 0.5, wrap_angle * 0.75]) {
        rotate([0, 0, angle])
        translate([inner_radius, -0.5, 0])
        cube([wall, 1, height]);
    }
}

// =====================================================
// TWIST-LOCK MECHANISM
// =====================================================

// Creates twist-lock tabs that insert into T-slot
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
// VERTICAL TUBE CLIP (tube perpendicular to profile)
// =====================================================

module vertical_tube_clip(tube_od=TUBE_OD_QUARTER_INCH) {
    inner_radius = tube_od / 2 + TOLERANCE;
    outer_radius = inner_radius + CLIP_WALL;

    difference() {
        union() {
            // Main mount block
            translate([-MOUNT_WIDTH/2, -outer_radius - CLIP_WALL/2, 0])
            rounded_cube([MOUNT_WIDTH, outer_radius + CLIP_WALL/2 + 5, MOUNT_HEIGHT], radius=1);

            // Tube clip body
            translate([0, 0, MOUNT_HEIGHT])
            tube_clip_body(tube_od=tube_od, height=20);
        }

        // T-slot insert space
        translate([-t_slot_insert_width()/2, -outer_radius - CLIP_WALL/2 - 0.1, T_SLOT_DEPTH])
        cube([t_slot_insert_width(), T_SLOT_DEPTH + 1, MOUNT_HEIGHT - T_SLOT_DEPTH + 0.1]);

        // Twist-lock channels on sides
        translate([-LOCK_TAB_WIDTH/2 - 2, -outer_radius - CLIP_WALL/2 - 0.1, T_SLOT_DEPTH - 1])
        rotate([0, 0, 0])
        twist_lock_channel();

        translate([LOCK_TAB_WIDTH/2 + 2, -outer_radius - CLIP_WALL/2 - 0.1, T_SLOT_DEPTH - 1])
        mirror([1, 0, 0])
        twist_lock_channel();
    }

    // Twist-lock tabs (rotate 45° when installing)
    translate([-LOCK_TAB_WIDTH/2, -outer_radius - CLIP_WALL/2, T_SLOT_DEPTH])
    twist_lock_tabs();

    translate([LOCK_TAB_WIDTH/2, -outer_radius - CLIP_WALL/2, T_SLOT_DEPTH])
    mirror([1, 0, 0])
    twist_lock_tabs();
}

// =====================================================
// HORIZONTAL TUBE CLIP (tube parallel to profile)
// =====================================================

module horizontal_tube_clip(tube_od=TUBE_OD_QUARTER_INCH, length=40) {
    inner_radius = tube_od / 2 + TOLERANCE;
    outer_radius = inner_radius + CLIP_WALL;

    difference() {
        union() {
            // Main mount block
            translate([0, -outer_radius - CLIP_WALL/2, 0])
            rounded_cube([length, outer_radius + CLIP_WALL/2 + 5, MOUNT_HEIGHT], radius=1);

            // Tube clip body (along length)
            translate([length/2, 0, MOUNT_HEIGHT])
            rotate([0, 90, 0])
            tube_clip_body(tube_od=tube_od, height=length, wrap_angle=CLIP_WRAP_ANGLE);
        }

        // T-slot insert spaces (two points for stability)
        for (x = [length * 0.25, length * 0.75]) {
            translate([x - t_slot_insert_width()/2, -outer_radius - CLIP_WALL/2 - 0.1, T_SLOT_DEPTH])
            cube([t_slot_insert_width(), T_SLOT_DEPTH + 1, MOUNT_HEIGHT - T_SLOT_DEPTH + 0.1]);

            // Twist-lock channels
            translate([x - LOCK_TAB_WIDTH/2 - 2, -outer_radius - CLIP_WALL/2 - 0.1, T_SLOT_DEPTH - 1])
            twist_lock_channel();

            translate([x + LOCK_TAB_WIDTH/2 + 2, -outer_radius - CLIP_WALL/2 - 0.1, T_SLOT_DEPTH - 1])
            mirror([1, 0, 0])
            twist_lock_channel();
        }
    }

    // Twist-lock tabs at two mounting points
    for (x = [length * 0.25, length * 0.75]) {
        translate([x - LOCK_TAB_WIDTH/2, -outer_radius - CLIP_WALL/2, T_SLOT_DEPTH])
        twist_lock_tabs();

        translate([x + LOCK_TAB_WIDTH/2, -outer_radius - CLIP_WALL/2, T_SLOT_DEPTH])
        mirror([1, 0, 0])
        twist_lock_tabs();
    }
}

// =====================================================
// MULTI-TUBE CLIP (holds 2-4 tubes)
// =====================================================

module multi_tube_clip(tube_od=TUBE_OD_QUARTER_INCH, tube_count=2, spacing=0) {
    inner_radius = tube_od / 2 + TOLERANCE;
    outer_radius = inner_radius + CLIP_WALL;

    // Auto-calculate spacing if not specified
    actual_spacing = (spacing > 0) ? spacing : tube_od + CLIP_WALL * 2;

    total_width = (tube_count - 1) * actual_spacing + outer_radius * 2 + CLIP_WALL;

    difference() {
        union() {
            // Main mount block
            translate([-total_width/2, -outer_radius - CLIP_WALL/2, 0])
            rounded_cube([total_width, outer_radius + CLIP_WALL/2 + 5, MOUNT_HEIGHT], radius=1);

            // Multiple tube clip bodies
            for (i = [0:tube_count-1]) {
                x_offset = (i - (tube_count - 1) / 2) * actual_spacing;
                translate([x_offset, 0, MOUNT_HEIGHT])
                tube_clip_body(tube_od=tube_od, height=20);
            }
        }

        // T-slot insert space
        translate([-t_slot_insert_width()/2, -outer_radius - CLIP_WALL/2 - 0.1, T_SLOT_DEPTH])
        cube([t_slot_insert_width(), T_SLOT_DEPTH + 1, MOUNT_HEIGHT - T_SLOT_DEPTH + 0.1]);

        // Twist-lock channels
        translate([-LOCK_TAB_WIDTH/2 - 2, -outer_radius - CLIP_WALL/2 - 0.1, T_SLOT_DEPTH - 1])
        twist_lock_channel();

        translate([LOCK_TAB_WIDTH/2 + 2, -outer_radius - CLIP_WALL/2 - 0.1, T_SLOT_DEPTH - 1])
        mirror([1, 0, 0])
        twist_lock_channel();
    }

    // Twist-lock tabs
    translate([-LOCK_TAB_WIDTH/2, -outer_radius - CLIP_WALL/2, T_SLOT_DEPTH])
    twist_lock_tabs();

    translate([LOCK_TAB_WIDTH/2, -outer_radius - CLIP_WALL/2, T_SLOT_DEPTH])
    mirror([1, 0, 0])
    twist_lock_tabs();
}

// =====================================================
// USAGE EXAMPLES (commented out)
// =====================================================

// Example: Vertical clip
/*
vertical_tube_clip(tube_od=TUBE_OD_QUARTER_INCH);
*/

// Example: Horizontal clip
/*
horizontal_tube_clip(tube_od=TUBE_OD_QUARTER_INCH, length=40);
*/

// Example: Multi-tube clip
/*
multi_tube_clip(tube_od=TUBE_OD_QUARTER_INCH, tube_count=3);
*/

// Example: With profile for fit testing
/*
translate([0, 30, 0])
    profile_2020(length=100);

vertical_tube_clip();
*/

echo("Tube Clip Library loaded");
echo(str("1/4\" tube OD: ", TUBE_OD_QUARTER_INCH, "mm"));
