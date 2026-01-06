// =====================================================
// Top Frame Component (Clamp Piece)
// =====================================================
// This is the top piece that:
// - Clamps the screen mesh from above
// - Screws down to the base frame
// - Has countersunk screw holes for flush mounting
// - Matches the base frame's connector pattern

include <../config.scad>

module top_frame_cell() {
    difference() {
        // Main frame body
        cube([CELL_WIDTH, CELL_LENGTH, TOP_FRAME_HEIGHT]);

        // Cut out inner opening for screen visibility
        translate([FRAME_WIDTH, FRAME_WIDTH, -0.1])
            cube([
                CELL_WIDTH - (2 * FRAME_WIDTH),
                CELL_LENGTH - (2 * FRAME_WIDTH),
                TOP_FRAME_HEIGHT + 0.2
            ]);

        // Add countersunk screw holes for attachment to base frame
        add_countersunk_screw_holes();
    }
}

// Add countersunk screw holes to match base frame screw pattern
module add_countersunk_screw_holes() {
    screw_spacing = (SCREWS_PER_EDGE > 1) ?
        CELL_LENGTH / (SCREWS_PER_EDGE + 1) :
        CELL_LENGTH / 2;

    hole_offset = FRAME_WIDTH / 2; // Center of frame width

    // Screw holes on all four edges

    // Front edge (Y-)
    for (i = [1:SCREWS_PER_EDGE]) {
        translate([
            i * screw_spacing,
            hole_offset,
            0
        ])
        countersunk_hole();
    }

    // Back edge (Y+)
    for (i = [1:SCREWS_PER_EDGE]) {
        translate([
            i * screw_spacing,
            CELL_LENGTH - hole_offset,
            0
        ])
        countersunk_hole();
    }

    // Left edge (X-)
    for (i = [1:SCREWS_PER_EDGE]) {
        translate([
            hole_offset,
            i * screw_spacing,
            0
        ])
        countersunk_hole();
    }

    // Right edge (X+)
    for (i = [1:SCREWS_PER_EDGE]) {
        translate([
            CELL_WIDTH - hole_offset,
            i * screw_spacing,
            0
        ])
        countersunk_hole();
    }

    // Corner screw holes
    corner_offset = FRAME_WIDTH / 2;
    translate([corner_offset, corner_offset, 0])
        countersunk_hole();
    translate([CELL_WIDTH - corner_offset, corner_offset, 0])
        countersunk_hole();
    translate([corner_offset, CELL_LENGTH - corner_offset, 0])
        countersunk_hole();
    translate([CELL_WIDTH - corner_offset, CELL_LENGTH - corner_offset, 0])
        countersunk_hole();
}

// Create a single countersunk screw hole
module countersunk_hole() {
    // Main screw shaft hole
    translate([0, 0, -0.1])
        cylinder(
            h = TOP_FRAME_HEIGHT + 0.2,
            d = SCREW_HOLE_DIA,
            $fn = 30
        );

    // Countersink for screw head
    translate([0, 0, TOP_FRAME_HEIGHT - COUNTERSINK_DEPTH])
        cylinder(
            h = COUNTERSINK_DEPTH + 0.1,
            d = COUNTERSINK_DIA,
            $fn = 30
        );
}

// Render the component
top_frame_cell();
