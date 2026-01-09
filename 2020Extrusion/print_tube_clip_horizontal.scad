// =====================================================
// PRINTABLE: Horizontal Tube Clip (1/4" Tubing)
// =====================================================
// Twist-lock clip for mounting tubes parallel to 2020 profile
// Part of SCAD Toolkit - 2020Extrusion Library

include <config.scad>
use <lib/tube_clips.scad>

// =====================================================
// CUSTOMIZATION
// =====================================================

// Tube size (outer diameter in mm)
TUBE_SIZE = TUBE_OD_QUARTER_INCH;  // 1/4" = 6.35mm

// Clip length (mm) - adjust for your needs
CLIP_LENGTH = 40;  // 40mm standard length

// Uncomment for other sizes:
// CLIP_LENGTH = 30;   // Short
// CLIP_LENGTH = 50;   // Long
// CLIP_LENGTH = 60;   // Extra long

// =====================================================
// RENDER
// =====================================================

horizontal_tube_clip(tube_od=TUBE_SIZE, length=CLIP_LENGTH);

// =====================================================
// PRINT INFORMATION
// =====================================================

echo("===========================================");
echo("HORIZONTAL TUBE CLIP - 1/4\" Tubing");
echo("===========================================");
echo(str("Tube OD: ", TUBE_SIZE, "mm (", round(mm_to_inch(TUBE_SIZE) * 100) / 100, "\")"));
echo(str("Clip Length: ", CLIP_LENGTH, "mm"));
echo(str("Mounting Points: 2 (for stability)"));
echo("");
echo("INSTALLATION:");
echo("1. Insert tabs into T-slot opening");
echo("2. Push clip toward profile");
echo("3. Rotate 45° clockwise to lock");
echo("4. Slide tube through from side");
echo("");
echo("PRINT SETTINGS:");
echo("  Material: PETG or ABS recommended");
echo("  Infill: 25-30%");
echo("  Layer Height: 0.2mm");
echo("  Supports: None required");
echo("  Orientation: Print as-is (flat on bed)");
echo("===========================================");
