# Screen Frame 3D - Modular Reptile Enclosure Screen System

A fully parametric OpenSCAD library for creating customizable, modular screen frames perfect for reptile enclosure tops. Designed specifically for 3D printing on the Bambu Lab P1S.

## Features

- **Fully Customizable Grid Size**: Default 8"x8" cells, easily adjustable
- **Modular Design**: Create any size screen by combining cells
- **Integrated Connectors**: Built-in pin/socket system joins cells seamlessly
- **Sandwich Construction**: Screen material held securely between top and bottom frames
- **Optimized for 3D Printing**: Fits Bambu Lab P1S build volume (256x256mm)
- **Parametric Everything**: All dimensions adjustable via config file
- **Chameleon-Safe**: Designed for small reptiles with lightweight, secure construction

## Quick Start

### 1. Customize Your Screen Size

Edit `config.scad` to set your enclosure dimensions:

```openscad
// Default 8" x 8" cells
CELL_WIDTH = 203.2;   // 8 inches in mm
CELL_LENGTH = 203.2;  // 8 inches in mm

// Create a 16" x 16" screen (2x2 grid)
GRID_CELLS_X = 2;
GRID_CELLS_Y = 2;
```

### 2. Preview the Assembly

Open `screen_frame_assembly.scad` in OpenSCAD to see your complete frame:
- Adjust `EXPLODED_VIEW = true;` to see how pieces fit together
- Check dimensions in the console output

### 3. Test the Connector Fit (RECOMMENDED)

Before printing full cells, test your printer's tolerances:

**Open `test_connector_fit.scad`** - prints in ~15 minutes
- Exports two small test blocks (pin + socket)
- Try clicking them together
- If too tight: increase `TOLERANCE` in config.scad
- If too loose: decrease `TOLERANCE` in config.scad

### 4. Export 3MF Files (Recommended)

**Option A: Automated Export (Easy)**
```bash
./export_complete_set.py
```
This Python script will:
- Read your config.scad automatically
- Generate 3MF files for all parts you need
- Create complete build plate layouts (for small grids)
- Save everything to `output/` directory

**Option B: Manual Export (Traditional)**
1. Open `print_base_frame.scad` in OpenSCAD
2. Press F6 to render
3. File → Export → Export as 3MF
4. Repeat for `print_top_frame.scad`

**Option C: Build Plate Layout**
```bash
# Edit generate_build_plate.scad to set GENERATE_BASE_FRAMES = true
./export_3mf.sh
```

### 5. Print the Parts

Import the 3MF files into your slicer (Bambu Studio, OrcaSlicer, etc.)

**Print Settings:**
- Material: PETG or ASA (heat resistant for basking lamps)
- Infill: 20-30%
- Layer Height: 0.2mm
- Supports: None required
- Orientation: Print as-is (flat on bed)

**Print Quantity:**
- Base frames: GRID_CELLS_X × GRID_CELLS_Y (from your config)
- Top frames: Same as base frames

**Bed Size Requirements:**
- Default 8"×8" cell = 213mm × 213mm print size (includes connector pins)
- ✅ Fits 250×250mm bed with 37mm margin
- ✅ Fits 256×256mm bed (Bambu P1S) with 43mm margin

### 6. Assembly

1. **Cut your screen material** to size (slightly larger than total frame)
2. **Click base frame cells together**:
   - Each cell has pins on RIGHT and BACK edges
   - Each cell has sockets on LEFT and FRONT edges
   - Pins snap into sockets with a satisfying click
   - Build your grid from bottom-left to top-right
3. **Lay screen mesh** over the assembled base frame
4. **Place top frame cells** on top of the screen (they also click together)
5. **Screw together**: Use M3 countersunk screws through top into base
6. **Trim excess screen** material around edges
7. **Place on enclosure lip** and ensure secure fit

💡 **Tip:** Open `assembly_demo.scad` to see how cells connect!

## Project Structure

```
screenframe3d/
├── config.scad                  # ⚙️ Master configuration - EDIT THIS
├── export_complete_set.py       # 🚀 Automated 3MF exporter (RECOMMENDED)
├── export_3mf.sh                # 📦 Bash script for 3MF export
├── generate_build_plate.scad    # 🗂️ Multi-part build plate layout
├── test_connector_fit.scad      # 🧪 Test print for connector fit
├── assembly_demo.scad           # 📺 Visual guide showing how cells connect
├── screen_frame_assembly.scad   # 👀 Preview complete assembly
├── print_base_frame.scad        # 🖨️ Print file for base frames
├── print_top_frame.scad         # 🖨️ Print file for top frames
├── print_connectors.scad        # 🖨️ Optional spare connector parts
├── examples.scad                # 📚 Example configurations gallery
├── QUICK_START.md               # 🚀 5-minute setup guide
└── lib/
    ├── base_frame.scad          # Base frame component library
    ├── top_frame.scad           # Top frame component library
    └── connectors.scad          # Standalone connector library
```

## How the Click-Together System Works

Each cell has an integrated connector system:

**Pin Placement (Male Connectors):**
- RIGHT edge: 2 pins extending 10mm outward
- BACK edge: 2 pins extending 10mm outward

**Socket Placement (Female Connectors):**
- LEFT edge: 2 sockets, 11mm deep
- FRONT edge: 2 sockets, 11mm deep

**Assembly Pattern:**
```
Start here ↓
┌─────┬─────┐
│ 1st │ 2nd │  ← Add cells left to right
├─────┼─────┤
│ 3rd │ 4th │  ← Then move to next row
└─────┴─────┘
```

When you push two cells together:
1. Pins on Cell A's RIGHT edge insert into Cell B's LEFT sockets
2. The 11mm socket depth accommodates the 10mm pin perfectly
3. Cells click together flush with no gap
4. Top frame cells also click together the same way

**See it in action:** Open `assembly_demo.scad` and change `DEMO_MODE` to see:
- `"separated"` - View the connector features
- `"joining"` - See alignment during assembly
- `"connected"` - See the final flush fit

## Configuration Options

All settings in `config.scad`:

### Grid Configuration
```openscad
CELL_WIDTH = 203.2;      // Individual cell width (mm)
CELL_LENGTH = 203.2;     // Individual cell length (mm)
GRID_CELLS_X = 2;        // Number of cells horizontally
GRID_CELLS_Y = 2;        // Number of cells vertically
```

### Frame Dimensions
```openscad
FRAME_WIDTH = 20;        // How wide the frame border is (mm)
FRAME_THICKNESS = 8;     // Total height of frame (mm)
SCREEN_GAP = 1.5;        // Space for screen material (mm)
```

### Connection System
```openscad
SCREW_HOLE_DIA = 3.2;    // For M3 screws
CONNECTOR_PIN_DIA = 4;   // Pin diameter for cell joining
CONNECTORS_PER_EDGE = 2; // Number of connector pins per edge
```

## Common Configurations

### Small Enclosure (16" x 16")
```openscad
CELL_WIDTH = 203.2;
CELL_LENGTH = 203.2;
GRID_CELLS_X = 2;
GRID_CELLS_Y = 2;
```
**Prints needed:** 2 base frames, 2 top frames

### Medium Enclosure (24" x 16")
```openscad
CELL_WIDTH = 203.2;
CELL_LENGTH = 203.2;
GRID_CELLS_X = 3;
GRID_CELLS_Y = 2;
```
**Prints needed:** 6 base frames, 6 top frames

### Large Enclosure (24" x 24")
```openscad
CELL_WIDTH = 203.2;
CELL_LENGTH = 203.2;
GRID_CELLS_X = 3;
GRID_CELLS_Y = 3;
```
**Prints needed:** 9 base frames, 9 top frames

### Custom Cell Size (10" x 10")
```openscad
CELL_WIDTH = 254;   // 10 inches
CELL_LENGTH = 254;
GRID_CELLS_X = 2;
GRID_CELLS_Y = 2;
```

## Materials & Hardware

### 3D Printing Materials
- **Recommended:** PETG or ASA
  - Heat resistant (important near basking lamps)
  - Durable and strong
  - Weather resistant
- **Not Recommended:** PLA
  - Can warp/soften near heat lamps
  - Less durable long-term

### Screen Material
- Fiberglass window screen mesh
- Aluminum screen (for extra strength)
- Heavy-duty pet screen
- Size: Cut 1-2" larger than total frame size

### Hardware Needed
- **M3 x 8mm countersunk screws**
  - Quantity per cell: ~12-16 screws (varies by config)
  - Calculate total: (SCREWS_PER_EDGE × 4 + 4) × number_of_cells
- Example: 2x2 grid = ~48-64 screws total

## 3MF Export Tools

This project includes automated export tools to generate 3MF files ready for slicing.

### Quick Export Guide

**Fastest method:**
```bash
./export_complete_set.py
```

This will:
1. Read your config.scad settings
2. Calculate how many parts you need
3. Generate individual 3MF files for each part type
4. For small grids (≤4 cells), create complete build plate layouts
5. Save all files to `output/` directory

**What you get:**
- `base_frame_single.3mf` - Single base frame (multiply in slicer)
- `top_frame_single.3mf` - Single top frame (multiply in slicer)
- `connector_test.3mf` - Test print for fit verification
- `all_base_frames.3mf` - Complete set arranged (2×2 grids only)
- `all_top_frames.3mf` - Complete set arranged (2×2 grids only)

### Requirements

The export scripts require OpenSCAD to be installed:
```bash
# Ubuntu/Debian
sudo apt install openscad

# macOS
brew install openscad

# Windows
# Download from openscad.org
```

### Alternative Methods

**Bash script (simpler):**
```bash
./export_3mf.sh
```

**Build plate generator:**
1. Edit `generate_build_plate.scad`
2. Set `GENERATE_BASE_FRAMES = true` or `GENERATE_TOP_FRAMES = true`
3. Open in OpenSCAD → F6 → Export as 3MF

## Tips & Best Practices

### Design Tips
- **Start with default 8"x8" cells** - proven to work well
- **Larger cells = fewer prints** but require bigger printer bed
- **Smaller cells = more joints** but more flexible sizing
- **Add extra connectors** if cells don't align perfectly

### Printing Tips
- **Print all base frames first**, test assembly before printing tops
- **Use brim** for better bed adhesion on larger cells
- **Calibrate first layer** for proper connector fit
- **Test fit one set** before printing entire grid

### Assembly Tips
- **Dry fit everything** before adding screen
- **Pull screen tight** when clamping between frames
- **Work from center outward** when screwing frames together
- **Use washers** if screw heads don't sit flush

### Sizing Tips
- **Measure your enclosure opening** accurately
- **Account for lip depth** - frame should sit flat
- **Add clearance** - PERIMETER_CLEARANCE in config
- **Test with cardboard** template before printing

## Troubleshooting

### Connectors Too Tight/Loose
Adjust `TOLERANCE` in config.scad:
- Too tight: Increase TOLERANCE (try 0.3mm)
- Too loose: Decrease TOLERANCE (try 0.1mm)

### Screen Sags in Middle
- Use thicker frame: Increase `FRAME_WIDTH`
- Add internal support bars (future enhancement)
- Use smaller cells for larger screens

### Pieces Don't Line Up
- Check printer calibration
- Verify all cells use same config.scad
- Test fit connectors before full assembly

### Screws Don't Fit
- Verify screw size matches `SCREW_HOLE_DIA`
- Check `COUNTERSINK_DIA` for screw head
- May need to drill out holes slightly

## Future Enhancements

Ideas for expansion:
- Internal support bars for large screens
- Hinged access panels
- Integrated mounting clips
- Feed door cut-outs
- Lamp cord pass-throughs
- Locking mechanisms

## Use Case: Chameleon Enclosure

This system was designed specifically for a chameleon enclosure top:
- **Lightweight construction** - safe for small reptiles
- **Excellent ventilation** - critical for chameleon health
- **Secure screening** - prevents escapes
- **Heat resistant** - safe near UVB/basking lamps
- **Easy to remove** - for feeding and maintenance
- **Customizable size** - fits any enclosure

## License

This project is open source. Feel free to modify, share, and improve!

## Contributing

Suggestions and improvements welcome! This is a parametric system designed to be extended.

---

**Happy Printing! 🦎**
