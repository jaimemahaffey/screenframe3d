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
        union() {
            // Outer frame rectangle
            cube([CELL_WIDTH, CELL_LENGTH, TOP_FRAME_HEIGHT]);

            // Add connector pins on edges (male connectors)
            add_connector_pins();
        }

        // Cut out inner opening for screen visibility
        translate([FRAME_WIDTH, FRAME_WIDTH, -0.1])
            cube([
                CELL_WIDTH - (2 * FRAME_WIDTH),
                CELL_LENGTH - (2 * FRAME_WIDTH),
                TOP_FRAME_HEIGHT + 0.2
            ]);

        // Add countersunk screw holes for attachment to base frame
        add_countersunk_screw_holes();

        // Add connector sockets on opposite edges (female connectors)
        add_connector_sockets();
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

// Add male connector pins to two edges (right and back)
// Same pattern as base frame for alignment
module add_connector_pins() {
    pin_spacing = (CONNECTORS_PER_EDGE > 1) ?
        CELL_LENGTH / (CONNECTORS_PER_EDGE + 1) :
        CELL_LENGTH / 2;

    // Pins on right edge (X+)
    for (i = [1:CONNECTORS_PER_EDGE]) {
        translate([
            CELL_WIDTH,
            i * pin_spacing,
            TOP_FRAME_HEIGHT / 2
        ])
        rotate([0, 90, 0])
        cylinder(
            h = CONNECTOR_PIN_LENGTH,
            d = CONNECTOR_PIN_DIA - TOLERANCE,
            $fn = 30
        );
    }

    // Pins on back edge (Y+)
    for (i = [1:CONNECTORS_PER_EDGE]) {
        translate([
            i * pin_spacing,
            CELL_LENGTH,
            TOP_FRAME_HEIGHT / 2
        ])
        rotate([-90, 0, 0])
        cylinder(
            h = CONNECTOR_PIN_LENGTH,
            d = CONNECTOR_PIN_DIA - TOLERANCE,
            $fn = 30
        );
    }
}

// Add female connector sockets to two edges (left and front)
// Same pattern as base frame for alignment
module add_connector_sockets() {
    socket_spacing = (CONNECTORS_PER_EDGE > 1) ?
        CELL_LENGTH / (CONNECTORS_PER_EDGE + 1) :
        CELL_LENGTH / 2;

    // Sockets on left edge (X-)
    for (i = [1:CONNECTORS_PER_EDGE]) {
        translate([
            -0.1,
            i * socket_spacing,
            TOP_FRAME_HEIGHT / 2
        ])
        rotate([0, 90, 0])
        cylinder(
            h = CONNECTOR_SOCKET_DEPTH + 0.1,
            d = CONNECTOR_PIN_DIA + TOLERANCE,
            $fn = 30
        );
    }

    // Sockets on front edge (Y-)
    for (i = [1:CONNECTORS_PER_EDGE]) {
        translate([
            i * socket_spacing,
            -0.1,
            TOP_FRAME_HEIGHT / 2
        ])
        rotate([-90, 0, 0])
        cylinder(
            h = CONNECTOR_SOCKET_DEPTH + 0.1,
            d = CONNECTOR_PIN_DIA + TOLERANCE,
            $fn = 30
        );
    }
}

// Render the component
top_frame_cell();
