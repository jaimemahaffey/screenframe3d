# 3MF Export Guide

Complete guide for generating 3MF files from this OpenSCAD project.

## Why 3MF?

3MF (3D Manufacturing Format) is superior to STL because it:
- ✅ Contains metadata (part names, units, etc.)
- ✅ Smaller file sizes
- ✅ Better precision
- ✅ Native support in modern slicers (Bambu Studio, OrcaSlicer, PrusaSlicer)
- ✅ Can contain multiple objects in one file

## Quick Start

### 1. Install OpenSCAD

**Required for all export methods.**

```bash
# Ubuntu/Debian
sudo apt install openscad

# macOS (using Homebrew)
brew install openscad

# Windows
# Download installer from https://openscad.org/downloads.html
```

Verify installation:
```bash
openscad --version
```

### 2. Run the Export Script

**Easiest method - fully automated:**

```bash
./export_complete_set.py
```

This will:
1. Read your `config.scad` settings automatically
2. Calculate how many parts you need based on GRID_CELLS_X and GRID_CELLS_Y
3. Generate individual 3MF files for each part type
4. For small grids (2×2), create complete build plate layouts
5. Save everything to the `output/` directory

**Output files:**
```
output/
├── base_frame_single.3mf      # Single base frame cell
├── top_frame_single.3mf       # Single top frame cell
├── connector_test.3mf         # Test print for fit
├── all_base_frames.3mf        # Complete set (if grid ≤ 2×2)
└── all_top_frames.3mf         # Complete set (if grid ≤ 2×2)
```

## Alternative Export Methods

### Method 2: Bash Script

Simpler script that exports individual parts only:

```bash
./export_3mf.sh
```

**Good for:**
- Quick exports
- Systems without Python
- Exporting single parts only

### Method 3: Build Plate Generator

For custom multi-part layouts:

1. **Edit `generate_build_plate.scad`:**
   ```openscad
   GENERATE_BASE_FRAMES = true;  // or false for top frames
   GENERATE_TOP_FRAMES = false;
   ```

2. **Open in OpenSCAD GUI:**
   ```bash
   openscad generate_build_plate.scad
   ```

3. **Render and Export:**
   - Press F6 (full render)
   - File → Export → Export as 3MF
   - Save to desired location

**Good for:**
- Custom arrangements
- Previewing layouts before export
- Learning how parts fit together

### Method 4: Manual Export

For maximum control:

1. **Open any `.scad` file in OpenSCAD:**
   ```bash
   openscad print_base_frame.scad
   ```

2. **Render:**
   - Press F5 (preview) or F6 (full render)

3. **Export:**
   - File → Export → Export as 3MF
   - Choose filename and location

4. **Repeat for each part type**

## Troubleshooting

### "OpenSCAD not found"

Make sure OpenSCAD is installed and in your PATH:
```bash
which openscad  # Should show path to binary
```

If not found, you may need to add it to PATH or use full path:
```bash
/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD --version  # macOS
```

### "Export taking too long"

Rendering complex parts can take time. Factors affecting speed:
- `$fn` value in config.scad (higher = slower but smoother)
- Number of parts being generated
- Computer specs

**Solutions:**
- Reduce `$fn` in config.scad (try 30 instead of 60)
- Export single parts instead of complete sets
- Let it run - should complete in 1-5 minutes per part

### "Python script fails"

The Python script requires Python 3.6+:
```bash
python3 --version
```

If missing, install Python or use the bash script instead:
```bash
./export_3mf.sh
```

### "Parts look wrong in slicer"

1. **Check orientation:** Parts should be flat on build plate
2. **Check scale:** Should be in millimeters (OpenSCAD default)
3. **Re-export:** Sometimes corruption occurs, try exporting again

## Workflow Examples

### Example 1: Quick Single Cell Print

```bash
# Export just one base frame to test
openscad -o output/test_base.3mf --export-format 3mf print_base_frame.scad

# Import in slicer and print
```

### Example 2: Complete 2×2 Grid

```bash
# Make sure config.scad has:
# GRID_CELLS_X = 2
# GRID_CELLS_Y = 2

# Run automated export
./export_complete_set.py

# Import these into slicer:
# - output/all_base_frames.3mf (4 parts arranged)
# - output/all_top_frames.3mf (4 parts arranged)
```

### Example 3: Large Grid (3×3 or bigger)

```bash
# Run export (generates singles only for large grids)
./export_complete_set.py

# Import single part 3MFs into slicer:
# - output/base_frame_single.3mf
# - output/top_frame_single.3mf

# In slicer:
# 1. Use "multiply" feature to create 9 copies of each
# 2. Arrange on build plate
# 3. May need to print in multiple batches
```

## Slicer Import Tips

### Bambu Studio / OrcaSlicer

1. **Import 3MF:** File → Import → Import 3MF
2. **Auto-arrange:** Right-click → Auto Arrange
3. **Multiply parts:** Right-click part → Set Number of Copies
4. **Group parts:** Select multiple → Right-click → Group

### PrusaSlicer

1. **Import:** Drag 3MF file into slicer
2. **Multiply:** Right-click → Increase Instances
3. **Arrange:** Use arrange button on toolbar

### Cura

1. **Import:** File → Open File(s)
2. **Multiply:** Select part → Use Multiply tool
3. Note: Cura prefers STL, but 3MF works

## Advanced: Command Line Batch Export

Export multiple parts in one command:

```bash
# Export all individual parts
for file in print_base_frame.scad print_top_frame.scad test_connector_fit.scad; do
    openscad -o "output/$(basename "$file" .scad).3mf" --export-format 3mf "$file"
done
```

## File Size Comparison

Typical file sizes:
- Single base frame: 200-500 KB (3MF) vs 1-2 MB (STL)
- Single top frame: 200-500 KB (3MF) vs 1-2 MB (STL)
- Complete 2×2 set: 1-2 MB (3MF) vs 4-8 MB (STL)

3MF is 50-75% smaller than STL!

## Questions?

- See main README.md for general usage
- See QUICK_START.md for basic setup
- Check OpenSCAD documentation: https://openscad.org/documentation.html

---

**Pro Tip:** Always print the connector test (`connector_test.3mf`) first to verify your printer's tolerances before printing the full parts!
