// =====================================================
// Examples Gallery
// =====================================================
// This file shows different configuration examples
// Uncomment the example you want to see

// Include all modules
use <lib/base_frame.scad>
use <lib/top_frame.scad>
use <lib/connectors.scad>

// =====================================================
// EXAMPLE 1: Single Cell (8" × 8")
// =====================================================
// Uncomment to view:
/*
CELL_WIDTH = 203.2;
CELL_LENGTH = 203.2;
base_frame_cell();
translate([0, 0, 10])
    top_frame_cell();
*/

// =====================================================
// EXAMPLE 2: Small Screen (16" × 16" / 2×2 grid)
// =====================================================
// Uncomment to view:
/*
CELL_WIDTH = 203.2;
CELL_LENGTH = 203.2;
GRID_CELLS_X = 2;
GRID_CELLS_Y = 2;

for (x = [0:1]) {
    for (y = [0:1]) {
        translate([x * CELL_WIDTH, y * CELL_LENGTH, 0])
            base_frame_cell();
    }
}
*/

// =====================================================
// EXAMPLE 3: Medium Screen (24" × 16" / 3×2 grid)
// =====================================================
// Uncomment to view:
/*
CELL_WIDTH = 203.2;
CELL_LENGTH = 203.2;

for (x = [0:2]) {
    for (y = [0:1]) {
        translate([x * CELL_WIDTH, y * CELL_LENGTH, 0])
            base_frame_cell();
    }
}
*/

// =====================================================
// EXAMPLE 4: Large Cell (10" × 10")
// =====================================================
// For printers with larger build volume
/*
CELL_WIDTH = 254;
CELL_LENGTH = 254;
base_frame_cell();
*/

// =====================================================
// EXAMPLE 5: Rectangular Cells (12" × 8")
// =====================================================
// Custom aspect ratio cells
/*
CELL_WIDTH = 304.8;  // 12 inches
CELL_LENGTH = 203.2;  // 8 inches
base_frame_cell();
*/

// =====================================================
// EXAMPLE 6: Connector Test Print
// =====================================================
// Test if connectors fit properly on your printer
/*
// Print this test piece to verify connector fit
difference() {
    cube([50, 50, 5]);

    // Test socket
    translate([15, 25, 2.5])
        rotate([0, 90, 0])
        cylinder(h = 10, d = 4.2, $fn = 30);  // 4mm pin + 0.2 tolerance
}

// Test pin
translate([35, 25, 2.5])
    rotate([0, 90, 0])
    cylinder(h = 10, d = 3.8, $fn = 30);  // 4mm pin - 0.2 tolerance
*/

// =====================================================
// EXAMPLE 7: Complete Assembly with Color
// =====================================================
// Uncomment to view full assembly with colors

CELL_WIDTH = 203.2;
CELL_LENGTH = 203.2;

// 2x2 grid base frames (blue)
color("SteelBlue")
for (x = [0:1]) {
    for (y = [0:1]) {
        translate([x * CELL_WIDTH, y * CELL_LENGTH, 0])
            base_frame_cell();
    }
}

// Simulated screen mesh (transparent gray)
color([0.3, 0.3, 0.3, 0.3])
translate([20, 20, 3])
    cube([203.2*2 - 40, 203.2*2 - 40, 0.5]);

// 2x2 grid top frames (dark gray)
color("DarkSlateGray")
for (x = [0:1]) {
    for (y = [0:1]) {
        translate([x * CELL_WIDTH, y * CELL_LENGTH, 4.5])
            top_frame_cell();
    }
}

// =====================================================
// RENDERING NOTES
// =====================================================
/*
To export any example:
1. Uncomment the example you want
2. Press F5 for preview (fast)
3. Press F6 for render (slow, high quality)
4. Press F7 to export STL
*/
