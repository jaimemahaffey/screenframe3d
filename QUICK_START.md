# Quick Start Guide

## 5-Minute Setup

### Step 1: Choose Your Size
Open `config.scad` and set these two values:

```openscad
// For a 16"x16" screen (2x2 grid of 8" cells):
GRID_CELLS_X = 2;  // Width in cells
GRID_CELLS_Y = 2;  // Length in cells
```

### Step 2: Preview
Open `screen_frame_assembly.scad` in OpenSCAD - you'll see your complete screen frame!

### Step 3: Export STL Files
1. Open `print_base_frame.scad` → Press F6 → Export STL
2. Open `print_top_frame.scad` → Press F6 → Export STL

### Step 4: Print
- **Base frames:** Print 4 copies (2×2 grid)
- **Top frames:** Print 4 copies (2×2 grid)
- **Material:** PETG or ASA
- **Infill:** 20-30%
- **No supports needed**

### Step 5: Assemble
1. Connect base frame cells together (pins snap into sockets)
2. Lay screen mesh on top
3. Place top frames over screen
4. Screw top to base with M3 screws
5. Trim excess screen
6. Place on enclosure!

## Common Size Calculator

| Enclosure Size | Cell Size | Grid | Prints Needed (base + top) |
|----------------|-----------|------|----------------------------|
| 16" × 16"      | 8" × 8"   | 2×2  | 4 + 4 = 8 total           |
| 24" × 16"      | 8" × 8"   | 3×2  | 6 + 6 = 12 total          |
| 24" × 24"      | 8" × 8"   | 3×3  | 9 + 9 = 18 total          |
| 32" × 16"      | 8" × 8"   | 4×2  | 8 + 8 = 16 total          |

## You Only Need to Edit config.scad!

Everything else auto-updates based on your settings.

## Questions?

See the full README.md for detailed instructions.
