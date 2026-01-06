// =====================================================
// ASSEMBLY DEMONSTRATION
// =====================================================
// Visual guide showing how cells click together
// Use this to understand the connector system

include <config.scad>
use <lib/base_frame.scad>

// =====================================================
// DEMO MODES
// =====================================================

// Set which demo to show
DEMO_MODE = "separated"; // Options: "separated", "joining", "connected"

// =====================================================
// TWO CELLS CONNECTING
// =====================================================

module two_cells_demo() {
    if (DEMO_MODE == "separated") {
        // Cells separated to show connector features
        color("SteelBlue") base_frame_cell();

        color("Orange")
        translate([CELL_WIDTH + 30, 0, 0])  // 30mm gap to see features
        base_frame_cell();

        // Add labels
        color("red")
        translate([CELL_WIDTH + 5, CELL_LENGTH/2, 10])
        rotate([0, 0, -90])
        linear_extrude(1)
        text("PINS →", size=8, halign="center");

        color("red")
        translate([CELL_WIDTH + 25, CELL_LENGTH/2, 10])
        rotate([0, 0, -90])
        linear_extrude(1)
        text("← SOCKETS", size=8, halign="center");
    }

    if (DEMO_MODE == "joining") {
        // Cells partially joined
        color("SteelBlue") base_frame_cell();

        color("Orange", alpha=0.7)
        translate([CELL_WIDTH + 5, 0, 0])  // 5mm gap - mid-insertion
        base_frame_cell();

        // Arrow showing direction
        color("red")
        translate([CELL_WIDTH + 2.5, CELL_LENGTH/2, 15])
        rotate([0, 0, -90])
        linear_extrude(1)
        text("↓ PUSH", size=8, halign="center");
    }

    if (DEMO_MODE == "connected") {
        // Cells fully connected (flush)
        color("SteelBlue") base_frame_cell();

        color("Orange")
        translate([CELL_WIDTH, 0, 0])  // No gap - fully connected
        base_frame_cell();

        // Checkmark
        color("green")
        translate([CELL_WIDTH, CELL_LENGTH/2, 15])
        rotate([0, 0, -90])
        linear_extrude(1)
        text("✓ LOCKED", size=8, halign="center");
    }
}

// =====================================================
// FOUR CELLS IN 2×2 GRID
// =====================================================

module four_cells_demo() {
    // Show how a 2×2 grid connects
    for (x = [0:1]) {
        for (y = [0:1]) {
            color((x+y)%2==0 ? "SteelBlue" : "Orange")
            translate([x * CELL_WIDTH, y * CELL_LENGTH, 0])
            base_frame_cell();
        }
    }

    // Labels
    color("white")
    translate([CELL_WIDTH, CELL_LENGTH, 10])
    linear_extrude(1)
    text("2×2 GRID", size=12, halign="center");
}

// =====================================================
// CONNECTOR CLOSEUP
// =====================================================

module connector_closeup() {
    // Zoomed view of just the connector region

    // Base cell section with pin
    difference() {
        cube([40, 40, BOTTOM_FRAME_HEIGHT]);
        translate([20, 20, -0.1])
        cylinder(h=10, d=15, $fn=6); // Hex cutout for visibility
    }

    // Pin extending
    color("green")
    translate([40, 20, BOTTOM_FRAME_HEIGHT/2])
    rotate([0, 90, 0])
    cylinder(h=CONNECTOR_PIN_LENGTH, d=CONNECTOR_PIN_DIA - TOLERANCE, $fn=30);

    // Socket block
    translate([50, 0, 0])
    difference() {
        cube([40, 40, BOTTOM_FRAME_HEIGHT]);

        // Socket hole
        translate([-0.1, 20, BOTTOM_FRAME_HEIGHT/2])
        rotate([0, 90, 0])
        cylinder(h=CONNECTOR_SOCKET_DEPTH+0.1, d=CONNECTOR_PIN_DIA + TOLERANCE, $fn=30);

        // Hex cutout for visibility
        translate([20, 20, -0.1])
        cylinder(h=10, d=15, $fn=6);
    }

    // Dimension labels
    color("red")
    translate([40, 0, BOTTOM_FRAME_HEIGHT + 2])
    linear_extrude(0.5)
    text(str(CONNECTOR_PIN_LENGTH, "mm"), size=3);
}

// =====================================================
// RENDER SELECTED DEMO
// =====================================================

// Uncomment the demo you want to see:

two_cells_demo();
// four_cells_demo();
// connector_closeup();

// =====================================================
// INSTRUCTIONS
// =====================================================

echo("===========================================");
echo("ASSEMBLY DEMO");
echo("===========================================");
echo("Change DEMO_MODE at the top of this file:");
echo("  'separated' - See connector features");
echo("  'joining'   - See how cells align");
echo("  'connected' - See final flush fit");
echo("");
echo("Or uncomment different demo modules:");
echo("  two_cells_demo()    - Basic connection");
echo("  four_cells_demo()   - 2×2 grid example");
echo("  connector_closeup() - Detailed view");
echo("===========================================");
