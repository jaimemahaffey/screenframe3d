// =====================================================
// 2020 Profile Accessories - Configuration
// =====================================================
// Part of SCAD Toolkit
// Status: IN DEVELOPMENT

// =====================================================
// PROFILE DIMENSIONS
// =====================================================

// Profile size (standard 2020 = 20mm x 20mm)
PROFILE_WIDTH = 20;   // mm
PROFILE_HEIGHT = 20;  // mm

// T-slot dimensions
T_SLOT_WIDTH = 6;     // mm (opening width)
T_SLOT_DEPTH = 9.2;   // mm (from profile edge)
T_SLOT_HEAD = 10.2;   // mm (internal width of head)

// Center hole
CENTER_HOLE_DIA = 4.2; // mm (M4 tap hole)

// =====================================================
// PRINT TOLERANCES
// =====================================================

// General tolerance for fit
TOLERANCE = 0.2;  // mm

// Tight fit (for press-fit)
TIGHT_FIT_TOLERANCE = 0.1;  // mm

// Loose fit (for sliding)
LOOSE_FIT_TOLERANCE = 0.4;  // mm

// =====================================================
// COMMON SETTINGS
// =====================================================

// Default wall thickness
WALL_THICKNESS = 2.5;  // mm

// Minimum feature size
MIN_FEATURE_SIZE = 1.0;  // mm

// Resolution for curves
$fn = 60;

// =====================================================
// CLIP PARAMETERS
// =====================================================

// Tube clip settings
TUBE_CLIP_WALL = 2.0;        // mm
TUBE_CLIP_GAP = 0.3;         // mm (for spring action)
TUBE_CLIP_MOUNT_HEIGHT = 15; // mm

// Common tube diameters (OD in mm)
TUBE_DIA_6MM = 6;
TUBE_DIA_8MM = 8;
TUBE_DIA_10MM = 10;
TUBE_DIA_12MM = 12;
TUBE_DIA_16MM = 16;

// =====================================================
// MOUNTING PARAMETERS
// =====================================================

// Planter mount settings
PLANTER_BRACKET_DEPTH = 30;   // mm
PLANTER_BRACKET_HEIGHT = 40;  // mm
PLANTER_SUPPORT_ANGLE = 45;   // degrees

// =====================================================
// FUTURE EXPANSION
// =====================================================

// Placeholder for additional parameters
// - Cable management
// - Corner brackets
// - Panel clips
// - etc.

// =====================================================
// HELPER FUNCTIONS
// =====================================================

// Calculate T-slot insert width for snug fit
function t_slot_insert_width() = T_SLOT_HEAD - TOLERANCE;

// Calculate T-slot neck width
function t_slot_neck_width() = T_SLOT_WIDTH - TOLERANCE;

echo("===========================================");
echo("2020 PROFILE CONFIGURATION");
echo("===========================================");
echo(str("Profile Size: ", PROFILE_WIDTH, "x", PROFILE_HEIGHT, "mm"));
echo(str("T-Slot Width: ", T_SLOT_WIDTH, "mm"));
echo(str("Tolerance: ", TOLERANCE, "mm"));
echo("===========================================");
echo("STATUS: IN DEVELOPMENT");
echo("This library is currently being built.");
echo("===========================================");
