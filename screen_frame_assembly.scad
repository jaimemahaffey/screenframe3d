// =====================================================
// Screen Frame Assembly - Main Example File
// =====================================================
// This file demonstrates how to assemble a complete screen frame
// Adjust the config.scad file to customize dimensions and grid size

include <config.scad>
use <lib/base_frame.scad>
use <lib/top_frame.scad>

// =====================================================
// ASSEMBLY PARAMETERS
// =====================================================

// What to show (set to true/false)
SHOW_BASE_FRAMES = true;
SHOW_TOP_FRAMES = true;
SHOW_SCREEN = true;  // Visualize screen mesh

// Exploded view (separates layers for visualization)
EXPLODED_VIEW = false;
EXPLODE_DISTANCE = 20; // Distance between layers in exploded view

// Color scheme
COLOR_BASE = "SteelBlue";
COLOR_TOP = "DarkSlateGray";
COLOR_SCREEN = [0.3, 0.3, 0.3, 0.3]; // Semi-transparent gray

// =====================================================
// ASSEMBLY
// =====================================================

module complete_frame_assembly() {
    // Base frame grid
    if (SHOW_BASE_FRAMES) {
        color(COLOR_BASE)
        base_frame_grid();
    }

    // Screen mesh visualization
    if (SHOW_SCREEN) {
        translate([0, 0, BOTTOM_FRAME_HEIGHT])
        color(COLOR_SCREEN)
        screen_mesh();
    }

    // Top frame grid
    if (SHOW_TOP_FRAMES) {
        translate([
            0,
            0,
            BOTTOM_FRAME_HEIGHT + SCREEN_GAP + (EXPLODED_VIEW ? EXPLODE_DISTANCE : 0)
        ])
        color(COLOR_TOP)
        top_frame_grid();
    }
}

// Generate grid of base frame cells
module base_frame_grid() {
    for (x = [0:GRID_CELLS_X-1]) {
        for (y = [0:GRID_CELLS_Y-1]) {
            translate([x * CELL_WIDTH, y * CELL_LENGTH, 0])
                base_frame_cell();
        }
    }
}

// Generate grid of top frame cells
module top_frame_grid() {
    for (x = [0:GRID_CELLS_X-1]) {
        for (y = [0:GRID_CELLS_Y-1]) {
            translate([x * CELL_WIDTH, y * CELL_LENGTH, 0])
                top_frame_cell();
        }
    }
}

// Visualize screen mesh
module screen_mesh() {
    mesh_width = (CELL_WIDTH * GRID_CELLS_X) - (2 * FRAME_WIDTH);
    mesh_length = (CELL_LENGTH * GRID_CELLS_Y) - (2 * FRAME_WIDTH);

    translate([FRAME_WIDTH, FRAME_WIDTH, 0])
        cube([mesh_width, mesh_length, 0.5]); // Thin representation of screen
}

// =====================================================
// RENDER COMPLETE ASSEMBLY
// =====================================================

complete_frame_assembly();

// =====================================================
// REFERENCE INFORMATION
// =====================================================

echo("===========================================");
echo("SCREEN FRAME ASSEMBLY INFO");
echo("===========================================");
echo(str("Grid Configuration: ", GRID_CELLS_X, " x ", GRID_CELLS_Y, " cells"));
echo(str("Cell Size: ", CELL_WIDTH, " x ", CELL_LENGTH, " mm (",
    round(mm_to_inch(CELL_WIDTH)*10)/10, "\" x ",
    round(mm_to_inch(CELL_LENGTH)*10)/10, "\")"));
echo(str("Total Frame Size: ", TOTAL_OUTER_WIDTH, " x ", TOTAL_OUTER_LENGTH, " mm (",
    round(mm_to_inch(TOTAL_OUTER_WIDTH)*10)/10, "\" x ",
    round(mm_to_inch(TOTAL_OUTER_LENGTH)*10)/10, "\")"));
echo(str("Total Frame Height: ", TOTAL_FRAME_HEIGHT, " mm"));
echo(str("Screen Opening: ", INNER_OPENING_WIDTH * GRID_CELLS_X, " x ",
    INNER_OPENING_LENGTH * GRID_CELLS_Y, " mm"));
echo("===========================================");
echo("PRINTING INSTRUCTIONS:");
echo(str("- Print ", GRID_CELLS_X * GRID_CELLS_Y, " base frame cells"));
echo(str("- Print ", GRID_CELLS_X * GRID_CELLS_Y, " top frame cells"));
echo(str("- You'll need M3 screws (approx ",
    (SCREWS_PER_EDGE * 4 + 4) * GRID_CELLS_X * GRID_CELLS_Y, " total)"));
echo("===========================================");
