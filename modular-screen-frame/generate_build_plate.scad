// =====================================================
// Build Plate Generator
// =====================================================
// Generates a printable layout with multiple parts
// arranged on a virtual build plate

include <config.scad>
use <lib/base_frame.scad>
use <lib/top_frame.scad>

// =====================================================
// BUILD PLATE CONFIGURATION
// =====================================================

// What to generate
GENERATE_BASE_FRAMES = true;
GENERATE_TOP_FRAMES = false;  // Set to true to generate top frames instead

// How many parts to fit on plate (based on your config)
PARTS_TO_GENERATE = GRID_CELLS_X * GRID_CELLS_Y;

// Build plate dimensions (Bambu P1S = 256x256mm)
BUILD_PLATE_WIDTH = 250;   // 250mm usable area
BUILD_PLATE_LENGTH = 250;  // 250mm usable area

// Spacing between parts
PART_SPACING = 5;  // 5mm gap between parts

// =====================================================
// AUTOMATIC LAYOUT CALCULATION
// =====================================================

// Part dimensions including pins
PART_WIDTH = CELL_WIDTH + CONNECTOR_PIN_LENGTH;
PART_LENGTH = CELL_LENGTH + CONNECTOR_PIN_LENGTH;

// How many parts fit per row
PARTS_PER_ROW = floor((BUILD_PLATE_WIDTH + PART_SPACING) / (PART_WIDTH + PART_SPACING));

// Calculate rows needed
ROWS_NEEDED = ceil(PARTS_TO_GENERATE / PARTS_PER_ROW);

// Check if all parts fit
TOTAL_WIDTH_NEEDED = (PARTS_PER_ROW * PART_WIDTH) + ((PARTS_PER_ROW - 1) * PART_SPACING);
TOTAL_LENGTH_NEEDED = (ROWS_NEEDED * PART_LENGTH) + ((ROWS_NEEDED - 1) * PART_SPACING);

PARTS_FIT_ON_PLATE = (TOTAL_WIDTH_NEEDED <= BUILD_PLATE_WIDTH) &&
                     (TOTAL_LENGTH_NEEDED <= BUILD_PLATE_LENGTH);

// =====================================================
// LAYOUT GENERATION
// =====================================================

module build_plate_layout() {
    if (!PARTS_FIT_ON_PLATE) {
        echo("⚠️  WARNING: Parts don't fit on build plate!");
        echo(str("  Required: ", TOTAL_WIDTH_NEEDED, "x", TOTAL_LENGTH_NEEDED, "mm"));
        echo(str("  Available: ", BUILD_PLATE_WIDTH, "x", BUILD_PLATE_LENGTH, "mm"));
        echo("  Reduce PARTS_TO_GENERATE or print in batches");
    }

    // Generate parts in grid layout
    for (i = [0:PARTS_TO_GENERATE-1]) {
        row = floor(i / PARTS_PER_ROW);
        col = i % PARTS_PER_ROW;

        x_pos = col * (PART_WIDTH + PART_SPACING);
        y_pos = row * (PART_LENGTH + PART_SPACING);

        translate([x_pos, y_pos, 0]) {
            if (GENERATE_BASE_FRAMES) {
                base_frame_cell();
            } else if (GENERATE_TOP_FRAMES) {
                top_frame_cell();
            }
        }
    }
}

// =====================================================
// RENDER
// =====================================================

build_plate_layout();

// =====================================================
// BUILD INFORMATION
// =====================================================

echo("=====================================");
echo("BUILD PLATE LAYOUT");
echo("=====================================");
echo(str("Grid Configuration: ", GRID_CELLS_X, "x", GRID_CELLS_Y));
echo(str("Parts to Print: ", PARTS_TO_GENERATE));
echo(str("Part Type: ", GENERATE_BASE_FRAMES ? "BASE FRAMES" :
                       GENERATE_TOP_FRAMES ? "TOP FRAMES" : "NONE"));
echo("");
echo(str("Parts per Row: ", PARTS_PER_ROW));
echo(str("Rows Needed: ", ROWS_NEEDED));
echo(str("Layout Size: ", round(TOTAL_WIDTH_NEEDED), "x", round(TOTAL_LENGTH_NEEDED), "mm"));
echo(str("Build Plate: ", BUILD_PLATE_WIDTH, "x", BUILD_PLATE_LENGTH, "mm"));
echo(str("Fits on Plate: ", PARTS_FIT_ON_PLATE ? "YES ✓" : "NO ✗"));
echo("");

if (PARTS_FIT_ON_PLATE) {
    echo("✓ Ready to export!");
    echo("  Press F6 to render, then File → Export → Export as 3MF");
} else {
    echo("⚠️  Reduce parts or print in multiple batches");
    batches_needed = ceil(PARTS_TO_GENERATE / (PARTS_PER_ROW * floor(BUILD_PLATE_LENGTH / (PART_LENGTH + PART_SPACING))));
    echo(str("  Suggested batches: ", batches_needed));
}
echo("=====================================");
