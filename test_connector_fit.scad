// =====================================================
// CONNECTOR FIT TEST PIECE
// =====================================================
// Print this FIRST to verify connectors fit properly on your printer
// Adjust TOLERANCE in config.scad if needed

include <config.scad>

// =====================================================
// TEST PIECE 1: Socket Block (Female)
// =====================================================
module socket_test_block() {
    difference() {
        // Main block
        cube([30, 30, BOTTOM_FRAME_HEIGHT]);

        // Socket hole (same as in actual frame)
        translate([30, 15, BOTTOM_FRAME_HEIGHT / 2])
        rotate([0, 90, 0])
        cylinder(
            h = CONNECTOR_SOCKET_DEPTH + 0.1,
            d = CONNECTOR_PIN_DIA + TOLERANCE,
            $fn = 30
        );
    }

    // Label
    translate([5, 5, BOTTOM_FRAME_HEIGHT])
    linear_extrude(0.4)
    text("SOCKET", size = 4);
}

// =====================================================
// TEST PIECE 2: Pin Block (Male)
// =====================================================
module pin_test_block() {
    // Main block
    cube([30, 30, BOTTOM_FRAME_HEIGHT]);

    // Pin (same as in actual frame)
    translate([30, 15, BOTTOM_FRAME_HEIGHT / 2])
    rotate([0, 90, 0])
    cylinder(
        h = CONNECTOR_PIN_LENGTH,
        d = CONNECTOR_PIN_DIA - TOLERANCE,
        $fn = 30
    );

    // Label
    translate([8, 5, BOTTOM_FRAME_HEIGHT])
    linear_extrude(0.4)
    text("PIN", size = 4);
}

// =====================================================
// RENDER TEST PIECES
// =====================================================

// Socket block on left
socket_test_block();

// Pin block on right (separated for printing)
translate([50, 0, 0])
pin_test_block();

// =====================================================
// TEST INSTRUCTIONS
// =====================================================

echo("===========================================");
echo("CONNECTOR FIT TEST");
echo("===========================================");
echo(str("Pin Diameter: ", CONNECTOR_PIN_DIA - TOLERANCE, " mm"));
echo(str("Socket Diameter: ", CONNECTOR_PIN_DIA + TOLERANCE, " mm"));
echo(str("Pin Length: ", CONNECTOR_PIN_LENGTH, " mm"));
echo(str("Socket Depth: ", CONNECTOR_SOCKET_DEPTH, " mm"));
echo(str("Tolerance: ", TOLERANCE, " mm"));
echo("");
echo("AFTER PRINTING:");
echo("1. Try inserting the pin into the socket");
echo("2. It should click in snugly but not too tight");
echo("3. If too tight: Increase TOLERANCE in config.scad");
echo("4. If too loose: Decrease TOLERANCE in config.scad");
echo("===========================================");
