// =====================================================
// Screen Frame 3D - Configuration File
// =====================================================
// All dimensions in millimeters unless otherwise noted
//
// For reptile enclosure tops - customizable modular grid system
// Designed for Bambu Lab P1S (256x256mm build volume)
// Recommended materials: PETG or ASA for heat resistance

// =====================================================
// GRID CONFIGURATION
// =====================================================

// Default grid cell size (each modular piece dimension)
// Default: 8 inches = 203.2mm (fits on P1S with margin)
CELL_WIDTH = 203.2;  // 8 inches
CELL_LENGTH = 203.2; // 8 inches

// Number of cells in your screen frame
GRID_CELLS_X = 2; // Number of cells in X direction
GRID_CELLS_Y = 2; // Number of cells in Y direction

// =====================================================
// FRAME PROFILE DIMENSIONS
// =====================================================

// Frame width (how far the frame extends inward)
FRAME_WIDTH = 20;  // 20mm (~0.79 inches)

// Frame thickness (vertical height)
FRAME_THICKNESS = 8; // 8mm (~0.31 inches)

// Screen sandwich gap (space between top and bottom pieces for mesh)
SCREEN_GAP = 1.5; // 1.5mm - adjust for your screen material thickness

// Bottom frame height (portion below the screen)
BOTTOM_FRAME_HEIGHT = 3; // 3mm

// Top frame height (portion above the screen that clamps down)
TOP_FRAME_HEIGHT = 3; // 3mm

// =====================================================
// CONNECTION SYSTEM
// =====================================================

// Screw hole diameter for connecting top to bottom
SCREW_HOLE_DIA = 3.2; // M3 screw (adjust for your hardware)

// Countersink diameter for screw heads
COUNTERSINK_DIA = 6.5; // For M3 countersunk screws

// Countersink depth
COUNTERSINK_DEPTH = 2;

// Number of screw holes per edge
SCREWS_PER_EDGE = 2; // Adjust based on cell size

// =====================================================
// JOINERY BETWEEN CELLS
// =====================================================

// Connector pin diameter
CONNECTOR_PIN_DIA = 4;

// Connector pin length
CONNECTOR_PIN_LENGTH = 10;

// Connector socket depth (must be >= pin length for flush fit)
CONNECTOR_SOCKET_DEPTH = 11; // 1mm deeper than pin for easy insertion

// Number of connector pins per edge
CONNECTORS_PER_EDGE = 2;

// =====================================================
// ENCLOSURE FIT PARAMETERS
// =====================================================

// Clearance around perimeter (gap between frame and enclosure wall)
PERIMETER_CLEARANCE = 1; // 1mm clearance for easy fit

// Lip overhang (how far the bottom frame extends to sit on lip)
LIP_OVERHANG = 5; // 5mm overhang sits on enclosure lip

// =====================================================
// PRINT SETTINGS & TOLERANCES
// =====================================================

// General tolerance for fit (horizontal printer tolerance)
TOLERANCE = 0.2; // 0.2mm - adjust for your printer

// Minimum wall thickness for strength
MIN_WALL_THICKNESS = 2.5; // 2.5mm

// Resolution for curves
$fn = 60; // Smoothness of circles (decrease for faster preview)

// =====================================================
// CALCULATED VALUES (DO NOT MODIFY)
// =====================================================

// Total frame outer dimensions
TOTAL_OUTER_WIDTH = (CELL_WIDTH * GRID_CELLS_X);
TOTAL_OUTER_LENGTH = (CELL_LENGTH * GRID_CELLS_Y);

// Inner frame opening (where screen sits)
INNER_OPENING_WIDTH = CELL_WIDTH - (2 * FRAME_WIDTH);
INNER_OPENING_LENGTH = CELL_LENGTH - (2 * FRAME_WIDTH);

// Total frame height
TOTAL_FRAME_HEIGHT = BOTTOM_FRAME_HEIGHT + SCREEN_GAP + TOP_FRAME_HEIGHT;

// =====================================================
// HELPER FUNCTIONS
// =====================================================

// Convert inches to mm
function inch_to_mm(inches) = inches * 25.4;

// Convert mm to inches
function mm_to_inch(mm) = mm / 25.4;

// =====================================================
// QUICK PRESETS
// =====================================================

// Uncomment to use preset sizes:

// Small enclosure (16" x 16" / 406mm x 406mm)
// CELL_WIDTH = 203.2;
// CELL_LENGTH = 203.2;
// GRID_CELLS_X = 2;
// GRID_CELLS_Y = 2;

// Medium enclosure (24" x 16" / 610mm x 406mm)
// CELL_WIDTH = 203.2;
// CELL_LENGTH = 203.2;
// GRID_CELLS_X = 3;
// GRID_CELLS_Y = 2;

// Large enclosure (24" x 24" / 610mm x 610mm)
// CELL_WIDTH = 203.2;
// CELL_LENGTH = 203.2;
// GRID_CELLS_X = 3;
// GRID_CELLS_Y = 3;

// Custom cell size example (10" x 10")
// CELL_WIDTH = 254;
// CELL_LENGTH = 254;
