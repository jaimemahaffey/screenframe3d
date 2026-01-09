// =====================================================
// PRINTABLE: Multi-Tube Clip (1/4" Tubing)
// =====================================================
// Twist-lock clip for mounting multiple tubes to 2020 profile
// Part of SCAD Toolkit - 2020Extrusion Library

include <config.scad>
use <lib/tube_clips.scad>

// =====================================================
// CUSTOMIZATION
// =====================================================

// Tube size (outer diameter in mm)
TUBE_SIZE = TUBE_OD_QUARTER_INCH;  // 1/4" = 6.35mm

// Number of tubes to hold
TUBE_COUNT = 2;  // Options: 2, 3, or 4

// Spacing between tubes (0 = auto)
TUBE_SPACING = 0;  // Auto-calculates optimal spacing

// =====================================================
// RENDER
// =====================================================

multi_tube_clip(
    tube_od=TUBE_SIZE,
    tube_count=TUBE_COUNT,
    spacing=TUBE_SPACING
);

// =====================================================
// PRINT INFORMATION
// =====================================================

echo("===========================================");
echo("MULTI-TUBE CLIP - 1/4\" Tubing");
echo("===========================================");
echo(str("Tube OD: ", TUBE_SIZE, "mm (", round(mm_to_inch(TUBE_SIZE) * 100) / 100, "\")"));
echo(str("Tube Count: ", TUBE_COUNT));
echo(str("Spacing: ", TUBE_SPACING > 0 ? str(TUBE_SPACING, "mm") : "Auto"));
echo("");
echo("INSTALLATION:");
echo("1. Insert tabs into T-slot opening");
echo("2. Push clip toward profile");
echo("3. Rotate 45° clockwise to lock");
echo("4. Insert tubes from top");
echo("");
echo("USE CASES:");
echo("  • Irrigation lines");
echo("  • Air hose routing");
echo("  • Cable management");
echo("  • Grow tent plumbing");
echo("");
echo("PRINT SETTINGS:");
echo("  Material: PETG or ABS recommended");
echo("  Infill: 25-30%");
echo("  Layer Height: 0.2mm");
echo("  Supports: None required");
echo("  Orientation: Print as-is (flat on bed)");
echo("===========================================");
