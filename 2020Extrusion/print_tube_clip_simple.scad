// =====================================================
// PRINTABLE: Simple C-Clip Tube Holder (1/4" Tubing)
// =====================================================
// Press-fit C-shaped clip for quick tube mounting
// 1.5" x 1.5" base with M4 screw mounting
// Part of SCAD Toolkit - 2020Extrusion Library

include <config.scad>
use <lib/simple_clip.scad>

// =====================================================
// CUSTOMIZATION
// =====================================================

// Tube size (outer diameter in mm)
TUBE_SIZE = TUBE_OD_QUARTER_INCH;  // 1/4" = 6.35mm

// Base plate size (mm)
BASE_SIZE = 38;  // ~1.5 inches (38.1mm)

// Uncomment for other tube sizes:
// TUBE_SIZE = 8;    // 5/16" ≈ 8mm
// TUBE_SIZE = 10;   // 3/8" ≈ 10mm
// TUBE_SIZE = 12;   // 1/2" ≈ 12mm

// =====================================================
// RENDER
// =====================================================

simple_tube_clip(
    tube_od=TUBE_SIZE,
    base_width=BASE_SIZE,
    base_length=BASE_SIZE
);

// =====================================================
// PRINT INFORMATION
// =====================================================

echo("===========================================");
echo("SIMPLE C-CLIP TUBE HOLDER");
echo("===========================================");
echo(str("Tube OD: ", TUBE_SIZE, "mm (", round(mm_to_inch(TUBE_SIZE) * 100) / 100, "\")"));
echo(str("Base Size: ", BASE_SIZE, " x ", BASE_SIZE, "mm (",
    round(mm_to_inch(BASE_SIZE) * 10) / 10, "\" x ",
    round(mm_to_inch(BASE_SIZE) * 10) / 10, "\")"));
echo(str("C-Clip Height: ", C_CLIP_HEIGHT, "mm"));
echo("");
echo("INSTALLATION:");
echo("1. Insert tabs into T-slot opening");
echo("2. Push clip toward profile");
echo("3. Rotate 45° clockwise to lock");
echo("4. Press tube into C-clip opening");
echo("");
echo("FEATURES:");
echo("  • Simple C-shaped tube holder");
echo("  • Twist-lock profile mounting");
echo("  • Easy tube insertion/removal");
echo("  • No screws needed!");
echo("  • Internal grip ribs");
echo("");
echo("PRINT SETTINGS:");
echo("  Material: PETG or ABS recommended");
echo("  Infill: 30-40%");
echo("  Layer Height: 0.2mm");
echo("  Supports: None required");
echo("  Orientation: Print with base flat on bed");
echo("");
echo("HARDWARE NEEDED:");
echo("  • None! Tool-free installation");
echo("===========================================");
