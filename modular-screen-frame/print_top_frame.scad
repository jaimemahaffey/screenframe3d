// =====================================================
// PRINTABLE: Single Top Frame Cell
// =====================================================
// Use this file to print individual top frame cells
// Customize size in config.scad

include <config.scad>
use <lib/top_frame.scad>

// Render single top frame cell, ready to print
top_frame_cell();

echo("===========================================");
echo("PRINTING: TOP FRAME CELL");
echo("===========================================");
echo(str("Cell Size: ", CELL_WIDTH, " x ", CELL_LENGTH, " mm"));
echo(str("Height: ", TOP_FRAME_HEIGHT, " mm"));
echo(str("Recommended Material: PETG or ASA"));
echo(str("Recommended Infill: 20-30%"));
echo(str("Supports: Not required"));
echo("===========================================");
