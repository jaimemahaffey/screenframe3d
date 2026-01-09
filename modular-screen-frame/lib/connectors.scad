// =====================================================
// Connector Components
// =====================================================
// Standalone connector pieces for joining cells
// These can be used as:
// - Spare parts if integrated connectors break
// - Alternative joining method
// - Repair pieces

include <../config.scad>

// =====================================================
// EDGE CONNECTOR
// =====================================================
// Double-ended pin connector for joining two cells along an edge
module edge_connector() {
    cylinder(
        h = CONNECTOR_PIN_LENGTH * 2,
        d = CONNECTOR_PIN_DIA - TOLERANCE,
        center = true,
        $fn = 30
    );
}

// =====================================================
// CORNER CONNECTOR PLATE
// =====================================================
// Flat plate with pins for connecting four cells at corners
module corner_connector_plate() {
    plate_size = 15; // Size of corner plate
    plate_thickness = BOTTOM_FRAME_HEIGHT - 0.5;

    difference() {
        // Main plate body
        cube([plate_size, plate_size, plate_thickness], center = true);

        // Optional: add screw hole in center
        cylinder(
            h = plate_thickness + 0.2,
            d = SCREW_HOLE_DIA,
            center = true,
            $fn = 30
        );
    }

    // Add pins on four sides
    pin_offset = plate_size / 2;

    // Pin extending in +X direction
    translate([pin_offset, 0, 0])
        rotate([0, 90, 0])
        cylinder(
            h = CONNECTOR_PIN_LENGTH,
            d = CONNECTOR_PIN_DIA - TOLERANCE,
            $fn = 30
        );

    // Pin extending in -X direction
    translate([-pin_offset, 0, 0])
        rotate([0, -90, 0])
        cylinder(
            h = CONNECTOR_PIN_LENGTH,
            d = CONNECTOR_PIN_DIA - TOLERANCE,
            $fn = 30
        );

    // Pin extending in +Y direction
    translate([0, pin_offset, 0])
        rotate([-90, 0, 0])
        cylinder(
            h = CONNECTOR_PIN_LENGTH,
            d = CONNECTOR_PIN_DIA - TOLERANCE,
            $fn = 30
        );

    // Pin extending in -Y direction
    translate([0, -pin_offset, 0])
        rotate([90, 0, 0])
        cylinder(
            h = CONNECTOR_PIN_LENGTH,
            d = CONNECTOR_PIN_DIA - TOLERANCE,
            $fn = 30
        );
}

// =====================================================
// T-CONNECTOR
// =====================================================
// Three-way connector for T-junctions
module t_connector() {
    plate_size = 12;
    plate_thickness = BOTTOM_FRAME_HEIGHT - 0.5;

    difference() {
        // Main plate body
        hull() {
            translate([0, 0, 0])
                cylinder(d = plate_size, h = plate_thickness, center = true, $fn = 30);
            translate([plate_size/2, 0, 0])
                cylinder(d = plate_size, h = plate_thickness, center = true, $fn = 30);
        }

        // Screw hole in center
        cylinder(
            h = plate_thickness + 0.2,
            d = SCREW_HOLE_DIA,
            center = true,
            $fn = 30
        );
    }

    pin_offset = plate_size / 2;

    // Three pins for T-junction
    translate([pin_offset * 1.5, 0, 0])
        rotate([0, 90, 0])
        cylinder(
            h = CONNECTOR_PIN_LENGTH,
            d = CONNECTOR_PIN_DIA - TOLERANCE,
            $fn = 30
        );

    translate([0, pin_offset, 0])
        rotate([-90, 0, 0])
        cylinder(
            h = CONNECTOR_PIN_LENGTH,
            d = CONNECTOR_PIN_DIA - TOLERANCE,
            $fn = 30
        );

    translate([0, -pin_offset, 0])
        rotate([90, 0, 0])
        cylinder(
            h = CONNECTOR_PIN_LENGTH,
            d = CONNECTOR_PIN_DIA - TOLERANCE,
            $fn = 30
        );
}

// =====================================================
// CONNECTOR SET FOR PRINTING
// =====================================================
// Arranged set of connectors optimized for printing
module connector_set() {
    spacing = 20;

    // 4 edge connectors
    for (i = [0:3]) {
        translate([i * spacing, 0, CONNECTOR_PIN_LENGTH])
            edge_connector();
    }

    // 2 corner plates
    translate([0, spacing, 0])
        corner_connector_plate();
    translate([spacing, spacing, 0])
        corner_connector_plate();

    // 1 T-connector
    translate([spacing * 2, spacing, 0])
        t_connector();
}

// =====================================================
// RENDER
// =====================================================
// Uncomment the component you want to render:

edge_connector();
// corner_connector_plate();
// t_connector();
// connector_set();
