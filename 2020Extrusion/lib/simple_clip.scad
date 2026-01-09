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

    base_height = 8;  // Height of mounting base

    difference() {
        union() {
            // Mounting base plate
            translate([-base_width/2, -base_length/2, 0])
            rounded_cube([base_width, base_length, base_height], radius=2);

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

        // T-slot mounting holes (simple drop-in style)
        // Two M4 clearance holes for screws into T-slot
        hole_spacing = base_width * 0.5;

        translate([hole_spacing/2, 0, -0.1])
        cylinder(d=4.5, h=base_height + 0.2, $fn=30);  // M4 clearance

        translate([-hole_spacing/2, 0, -0.1])
        cylinder(d=4.5, h=base_height + 0.2, $fn=30);  // M4 clearance

        // Countersinks for flat head screws (optional)
        translate([hole_spacing/2, 0, base_height - 2])
        cylinder(d=8, h=2.1, $fn=30);

        translate([-hole_spacing/2, 0, base_height - 2])
        cylinder(d=8, h=2.1, $fn=30);
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
