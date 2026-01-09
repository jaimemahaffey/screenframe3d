# 2020 Extrusion Accessories

A collection of parametric connectors and accessories for 2020 aluminum extrusion profiles (20mm × 20mm T-slot aluminum).

## ✅ Available Components

### Simple C-Clip Tube Holder
**Status: Production Ready** 🎉 **RECOMMENDED FOR MOST USES**

The easiest way to mount tubes - just a simple press-fit C-clip!

**Features:**
- Simple C-shaped press-fit design
- 1.5" × 1.5" (38mm) compact base
- Two M4 screw mounting (standard hardware)
- Easy tube insertion/removal
- Internal grip ribs for secure hold
- Default: 1/4" (6.35mm) tubing

**File:** `print_tube_clip_simple.scad`

### Twist-Lock Tube Clips
**Status: Production Ready** 🎉

Advanced tool-free clips with twist-lock mechanism. Great when you can't use screws!

**Variants:**
- ✅ **Vertical Clip** - Tube perpendicular to profile
- ✅ **Horizontal Clip** - Tube parallel to profile (40mm length, 2 mounting points)
- ✅ **Multi-Tube Clip** - Holds 2-4 tubes in parallel

**Features:**
- Quick twist-lock installation (insert → push → rotate 45°)
- Default: 1/4" (6.35mm) tubing
- Parametric design - easily adjust for other tube sizes
- 270° wrap for secure grip
- No screws or tools required for installation

**Files:**
- `print_tube_clip_vertical.scad` - Single tube, perpendicular mount
- `print_tube_clip_horizontal.scad` - Single tube, parallel mount
- `print_tube_clip_multi.scad` - Multiple tubes (2-4)
- `assembly_demo.scad` - Visual installation guide

## 🚧 Planned Features

### Clips and Cable Management
- [x] Tube clips (1/4" standard, parametric for other sizes)
- [ ] Cable routing clips
- [ ] Wire management channels
- [ ] Hose holders

### Mounting Systems
- [ ] Planter mounts and brackets
- [ ] Shelf brackets
- [ ] Tool holders
- [ ] Camera/sensor mounts

### Structural Connectors
- [ ] 90-degree corner brackets
- [ ] T-connectors
- [ ] Cross connectors
- [ ] Adjustable angle joints

### Custom Accessories
- [ ] End caps
- [ ] Feet/leveling mounts
- [ ] Panel clips
- [ ] Parametric clamps

## 📐 2020 Profile Specifications

Standard 2020 aluminum extrusion:
- **Profile:** 20mm × 20mm
- **T-slot width:** 6mm
- **Center hole:** 4.2mm (M4 tap)
- **Material:** 6063-T5 aluminum alloy

## 🚀 Quick Start

### 1. Preview the Clips

Open `assembly_demo.scad` in OpenSCAD to see all clip variants on a reference profile:
```openscad
DEMO_MODE = "all";     // Shows all clip types
SHOW_PROFILE = true;   // Shows 2020 profile
SHOW_TUBES = true;     // Shows tubes in clips

// Options: "simple", "vertical", "horizontal", "multi", "all"
```

### 2. Customize (Optional)

Edit `config.scad` to adjust:
- Profile dimensions (if not standard 2020)
- Tube sizes
- Tolerances for your printer
- Wall thickness

### 3. Export and Print

**Option A: Quick Export**
```bash
./export.py
```

**Option B: Manual Export**
- Open `print_tube_clip_vertical.scad` (or horizontal/multi)
- Press F6 to render
- File → Export → Export as 3MF
- Repeat for other variants

**Print Settings:**
- **Material:** PETG or ABS (for strength and heat resistance)
- **Infill:** 25-30%
- **Layer Height:** 0.2mm
- **Supports:** None required
- **Orientation:** Print as-is (flat on bed)

### 4. Install on Profile

**Simple C-Clip (Recommended):**
1. **Position:** Place clip on profile where needed
2. **Screw:** Secure with 2× M4 screws into T-slot or drilled holes
3. **Insert:** Press tube into C-clip opening
4. **Done!** Internal ribs grip the tube

**Twist-Lock Clips (Tool-Free):**
1. **Insert:** Align tabs with T-slot opening
2. **Push:** Slide clip toward the profile face
3. **Twist:** Rotate 45° clockwise
4. **Lock:** Tabs engage in T-slot head
5. **Use:** Insert tubing from top (vertical) or side (horizontal)

## 🏗️ Project Structure

```
2020Extrusion/
├── README.md                          # This file
├── config.scad                        # Global configuration
├── assembly_demo.scad                 # Visual demo with all clips
├── export.py                          # Quick 3MF export script
├── lib/
│   ├── profile_base.scad             # Base 2020 profile module
│   ├── simple_clip.scad              # Simple C-clip library
│   └── tube_clips.scad               # Twist-lock tube clip library
├── print_tube_clip_simple.scad       # Simple C-clip (RECOMMENDED)
├── print_tube_clip_vertical.scad     # Vertical twist-lock clip
├── print_tube_clip_horizontal.scad   # Horizontal twist-lock clip
└── print_tube_clip_multi.scad        # Multi-tube twist-lock clip
```

## 🎨 Design Goals

### Parametric
All designs fully parametric - adjust for any profile size (2020, 2040, etc.)

### T-Slot Compatible
Properly sized for standard T-slot dimensions with adjustable tolerances

### Tool-Free Installation
Twist-lock design - no screws or tools required

### Reusable
Common patterns extracted to shared library modules

## 💡 Use Cases

### Twist-Lock Tube Clips

**Hydroponics & Grow Tents:**
- Irrigation line routing
- Nutrient delivery systems
- Misting system tubing
- Air circulation hoses

**Workbenches & Labs:**
- Compressed air lines
- Vacuum tubing
- Water cooling systems
- Chemical transfer lines

**3D Printer Farms:**
- Filament dryer ducting
- Cooling system hoses
- Bowden tube routing
- Cable management

**General Applications:**
- Aquarium plumbing
- Pneumatic systems
- Custom liquid cooling
- Workshop organization

## 🔧 Customization Guide

### Which Clip Should I Use?

**Use Simple C-Clip when:**
- You have M4 screws and T-nuts available
- You want the simplest, most reliable design
- You need frequently accessed tubes (easy removal)
- Compact size is important (1.5" × 1.5")

**Use Twist-Lock Clips when:**
- You can't use screws (temporary setup)
- Tool-free installation is required
- You need to reposition clips frequently
- Mounting multiple tubes in a row

### Custom Tube Sizes

Edit any `print_tube_clip_*.scad` file:

```openscad
// Change this line to your tube OD
TUBE_SIZE = 8;  // 8mm OD tubing

// Common sizes:
// 6.35mm  - 1/4"
// 8mm     - 5/16"
// 10mm    - 3/8"
// 12mm    - 1/2"
```

### Adjust Fit Tolerance

Edit `config.scad`:

```openscad
TOLERANCE = 0.2;  // Default
TOLERANCE = 0.3;  // Looser fit
TOLERANCE = 0.1;  // Tighter fit
```

### Multi-Tube Spacing

In `print_tube_clip_multi.scad`:

```openscad
TUBE_COUNT = 3;     // Number of tubes
TUBE_SPACING = 15;  // Custom spacing (0 = auto)
```

## 🤝 Contributing

Contributions welcome! Planned additions:
1. ✅ Twist-lock tube clips (DONE)
2. [ ] Planter mount system
3. [ ] Corner brackets and connectors
4. [ ] Camera/sensor mounts

## 📚 Resources

- [80/20 Inc.](https://8020.net/) - T-slot framing systems
- [Misumi](https://us.misumi-ec.com/) - Aluminum extrusion supplier
- [OpenBuilds](https://openbuildspartstore.com/) - V-Slot aluminum extrusion

---

**Ready to print!** 🎉
