// =====================================================
// Tube Clip Assembly Demo
// =====================================================
// Visual demonstration of tube clips on 2020 profile
// Part of SCAD Toolkit - 2020Extrusion Library

include <config.scad>
use <lib/profile_base.scad>
use <lib/tube_clips.scad>

// =====================================================
// DEMO MODE
// =====================================================

DEMO_MODE = "all";  // Options: "vertical", "horizontal", "multi", "all"

// Show reference profile?
SHOW_PROFILE = true;

// Show tubes in clips?
SHOW_TUBES = true;

// Tube color
TUBE_COLOR = "DodgerBlue";

// =====================================================
// REFERENCE PROFILE
// =====================================================

if (SHOW_PROFILE) {
    color("Silver", alpha=0.5)
    profile_2020(length=150, show_center_hole=true);
}

// =====================================================
// DEMO SCENES
// =====================================================

if (DEMO_MODE == "vertical" || DEMO_MODE == "all") {
    // Vertical clip demo
    translate([0, 0, 30]) {
        color("SteelBlue")
        vertical_tube_clip(tube_od=TUBE_OD_QUARTER_INCH);

        // Simulated tube
        if (SHOW_TUBES) {
            color(TUBE_COLOR)
            translate([0, 0, 35])
            cylinder(d=TUBE_OD_QUARTER_INCH, h=50, $fn=30);
        }
    }
}

if (DEMO_MODE == "horizontal" || DEMO_MODE == "all") {
    // Horizontal clip demo
    translate([50, 0, 0]) {
        color("OrangeRed")
        horizontal_tube_clip(tube_od=TUBE_OD_QUARTER_INCH, length=40);

        // Simulated tube
        if (SHOW_TUBES) {
            color(TUBE_COLOR)
            translate([20, 0, 15 + TUBE_OD_QUARTER_INCH/2 + CLIP_WALL + TOLERANCE])
            rotate([0, 90, 0])
            cylinder(d=TUBE_OD_QUARTER_INCH, h=60, center=true, $fn=30);
        }
    }
}

if (DEMO_MODE == "multi" || DEMO_MODE == "all") {
    // Multi-tube clip demo
    translate([100, 0, 0]) {
        color("DarkGreen")
        multi_tube_clip(tube_od=TUBE_OD_QUARTER_INCH, tube_count=3);

        // Simulated tubes
        if (SHOW_TUBES) {
            tube_spacing = TUBE_OD_QUARTER_INCH + CLIP_WALL * 2;
            for (i = [-1:1]) {
                color(TUBE_COLOR)
                translate([i * tube_spacing, 0, 35])
                cylinder(d=TUBE_OD_QUARTER_INCH, h=50, $fn=30);
            }
        }
    }
}

// =====================================================
// LABELS
// =====================================================

if (DEMO_MODE == "all") {
    color("white") {
        translate([0, 15, 0])
        linear_extrude(0.5)
        text("Vertical", size=4, halign="center");

        translate([50, 15, 0])
        linear_extrude(0.5)
        text("Horizontal", size=4, halign="center");

        translate([100, 15, 0])
        linear_extrude(0.5)
        text("Multi (3x)", size=4, halign="center");
    }
}

// =====================================================
// INSTRUCTIONS
// =====================================================

echo("===========================================");
echo("TUBE CLIP ASSEMBLY DEMO");
echo("===========================================");
echo("Change DEMO_MODE to view different clips:");
echo("  'vertical'   - Single vertical clip");
echo("  'horizontal' - Single horizontal clip");
echo("  'multi'      - Multi-tube clip");
echo("  'all'        - All clips shown");
echo("");
echo("Toggle options:");
echo("  SHOW_PROFILE - Show 2020 profile reference");
echo("  SHOW_TUBES   - Show tubes in clips");
echo("");
echo("TWIST-LOCK INSTALLATION:");
echo("1. Align tabs with T-slot opening");
echo("2. Push clip toward profile");
echo("3. Rotate 45° clockwise");
echo("4. Tabs lock into T-slot head");
echo("5. Insert tubing");
echo("===========================================");
