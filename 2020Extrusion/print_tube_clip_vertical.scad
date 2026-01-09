// =====================================================
// PRINTABLE: Vertical Tube Clip (1/4" Tubing)
// =====================================================
// Twist-lock clip for mounting tubes perpendicular to 2020 profile
// Part of SCAD Toolkit - 2020Extrusion Library

include <config.scad>
use <lib/tube_clips.scad>

// =====================================================
// CUSTOMIZATION
// =====================================================

// Tube size (outer diameter in mm)
TUBE_SIZE = TUBE_OD_QUARTER_INCH;  // 1/4" = 6.35mm

// Uncomment for other common sizes:
// TUBE_SIZE = 8;    // 5/16" ≈ 8mm
// TUBE_SIZE = 10;   // 3/8" ≈ 10mm
// TUBE_SIZE = 12;   // 1/2" ≈ 12mm

// =====================================================
// RENDER
// =====================================================

vertical_tube_clip(tube_od=TUBE_SIZE);

// =====================================================
// PRINT INFORMATION
// =====================================================

echo("===========================================");
echo("VERTICAL TUBE CLIP - 1/4\" Tubing");
echo("===========================================");
echo(str("Tube OD: ", TUBE_SIZE, "mm (", round(mm_to_inch(TUBE_SIZE) * 100) / 100, "\")"));
echo(str("Clip Wrap: ", CLIP_WRAP_ANGLE, "° (", CLIP_WRAP_ANGLE/360, " of circle)"));
echo("");
echo("INSTALLATION:");
echo("1. Insert tabs into T-slot opening");
echo("2. Push clip toward profile");
echo("3. Rotate 45° clockwise to lock");
echo("4. Insert tube from top");
echo("");
echo("PRINT SETTINGS:");
echo("  Material: PETG or ABS recommended");
echo("  Infill: 25-30%");
echo("  Layer Height: 0.2mm");
echo("  Supports: None required");
echo("  Orientation: Print as-is (flat on bed)");
echo("===========================================");
