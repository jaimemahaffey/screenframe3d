// =====================================================
// PRINTABLE: Single Base Frame Cell
// =====================================================
// Use this file to print individual base frame cells
// Customize size in config.scad

include <config.scad>
use <lib/base_frame.scad>

// Render single base frame cell, ready to print
base_frame_cell();

echo("===========================================");
echo("PRINTING: BASE FRAME CELL");
echo("===========================================");
echo(str("Cell Size: ", CELL_WIDTH, " x ", CELL_LENGTH, " mm"));
echo(str("Height: ", BOTTOM_FRAME_HEIGHT, " mm"));
echo(str("Recommended Material: PETG or ASA"));
echo(str("Recommended Infill: 20-30%"));
echo(str("Supports: Not required"));
echo("===========================================");
