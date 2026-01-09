# SCAD Toolkit

A collection of parametric OpenSCAD libraries for 3D printing. Each library is self-contained with documentation, examples, and export scripts.

## 📚 Libraries

### [Modular Screen Frame](modular-screen-frame/)
Parametric, modular screen frame system with click-together cells. Perfect for reptile enclosure tops, window screens, or custom ventilation panels.

**Features:**
- Fully customizable grid sizes (default 8"×8" cells)
- Click-together connector system
- Sandwich design for secure screen clamping
- Optimized for 250×250mm+ print beds
- Complete documentation and assembly guides

**Status:** ✅ Production Ready

### [2020 Profile Accessories](2020-profile/) *(Coming Soon)*
Connectors and accessories for 2020 aluminum extrusion profiles.

**Planned Features:**
- Tube clips and cable management
- Planter mounts and brackets
- Corner connectors
- Camera mounts
- Custom clamps

**Status:** 🚧 In Development

## 🛠️ Common Libraries

Shared utilities available to all projects:

### [common/connectors.scad](common/connectors.scad)
Reusable connector patterns:
- Pin and socket connectors
- Dovetail joints
- Snap-fit mechanisms
- T-slot profiles
- Ball and socket joints
- Spring clips

### [common/hardware.scad](common/hardware.scad)
Standard hardware components:
- Metric screws (M2, M3, M4, M5)
- Hex nuts and washers
- Heat-set inserts
- Screw holes with countersinks

### [common/utils.scad](common/utils.scad)
Helper functions and modules:
- Unit conversions (inch/mm/feet)
- Chamfers and fillets
- Rounded shapes
- Arrays (linear, grid, circular)
- Text embossing/debossing
- Living hinges
- Structural helpers (ribs, lattice infill)

## 🚀 Quick Start

### 1. Choose a Library

```bash
cd modular-screen-frame/    # or any other library
```

### 2. Customize Configuration

Each library has a `config.scad` file with all parameters:

```bash
# Edit the configuration
nano config.scad
```

### 3. Preview in OpenSCAD

```bash
openscad screen_frame_assembly.scad
```

### 4. Export 3MF Files

Each library has an export script:

```bash
# From the library directory
./export.py

# Or from the project root
cd ..
./scripts/export_library.py modular-screen-frame
```

### 5. Print!

Import the 3MF files into your slicer (Bambu Studio, OrcaSlicer, PrusaSlicer, etc.) and print.

## 📦 Exporting 3MF Files

### Export a Single Library

```bash
./scripts/export_library.py modular-screen-frame
```

### Export All Libraries

```bash
./scripts/export_library.py --all
```

### Custom Output Directory

```bash
./scripts/export_library.py modular-screen-frame -o /path/to/output
```

## 🏗️ Project Structure

```
scad-toolkit/
├── README.md                       # This file
├── common/                         # Shared utilities
│   ├── connectors.scad            # Common connector patterns
│   ├── hardware.scad              # Standard hardware
│   └── utils.scad                 # Helper functions
├── scripts/                        # Build and export tools
│   ├── export_library.py          # Generic 3MF exporter
│   ├── export_3mf.sh              # Legacy bash script
│   └── export_complete_set.py     # Legacy export script
├── modular-screen-frame/          # Screen frame library
│   ├── README.md                  # Library-specific docs
│   ├── config.scad                # Configuration file
│   ├── lib/                       # Library modules
│   ├── print_*.scad               # Printable components
│   ├── test_*.scad                # Test/calibration prints
│   └── export.py                  # Library export wrapper
└── 2020-profile/                  # Aluminum profile accessories
    └── README.md                  # Coming soon!
```

## 🎯 Using Common Libraries

All libraries can use the shared common modules:

```openscad
// In your .scad file
use <../common/connectors.scad>
use <../common/hardware.scad>
use <../common/utils.scad>

// Use shared modules
connector_pin(length=10, diameter=4);

M3_screw(length=15, type="countersunk");

rounded_cube(size=[20, 30, 5], radius=2);
```

## 📖 Library Development Guide

### Creating a New Library

1. **Create library directory:**
   ```bash
   mkdir my-new-library
   cd my-new-library
   ```

2. **Create basic files:**
   ```bash
   touch config.scad               # Configuration parameters
   touch README.md                 # Library documentation
   mkdir lib                       # Library modules
   touch print_example.scad        # Printable component
   ```

3. **Create export wrapper:**
   ```bash
   cp ../modular-screen-frame/export.py ./
   # Edit export.py to change the header text
   ```

4. **Use common libraries:**
   ```openscad
   use <../common/connectors.scad>
   use <../common/hardware.scad>
   use <../common/utils.scad>
   ```

5. **Document your library:**
   - Write a comprehensive README.md
   - Include Quick Start guide
   - Add configuration examples
   - Document all parameters

### Library Requirements

Each library should have:
- ✅ **config.scad** - Centralized configuration
- ✅ **README.md** - Complete documentation
- ✅ **lib/** - Reusable modules
- ✅ **print_*.scad** - Files ready to export
- ✅ **Assembly guide** - How to put it together
- ✅ **Examples** - Common use cases

### Naming Conventions

- **Configuration:** `config.scad`
- **Printable parts:** `print_*.scad` (e.g., `print_base_frame.scad`)
- **Test prints:** `test_*.scad` (e.g., `test_connector_fit.scad`)
- **Library modules:** `lib/*.scad`
- **Assembly previews:** `*_assembly.scad`

## 🛠️ Requirements

- **OpenSCAD** 2021.01 or later
- **Python 3.6+** (for export scripts)
- **Bash** (for legacy export scripts)

### Installing OpenSCAD

```bash
# Ubuntu/Debian
sudo apt install openscad

# macOS
brew install openscad

# Windows
# Download from https://openscad.org/downloads.html
```

## 🎨 Design Philosophy

### Modularity
Each library is self-contained and can work independently. Common utilities are optional but encouraged.

### Parametric Everything
All designs are fully parametric. Users should be able to customize any dimension via configuration files.

### Print-in-Place Friendly
Designs should minimize post-processing. Click-together parts, living hinges, and print-in-place mechanisms are preferred.

### Well-Documented
Every library needs comprehensive documentation, examples, and assembly guides.

### Tested Tolerances
Include test prints for connector fit verification. Provide tolerance adjustment guidance.

## 🤝 Contributing

Contributions welcome! To add a new library:

1. Follow the **Library Development Guide** above
2. Ensure complete documentation
3. Include test prints and assembly guides
4. Submit a pull request

## 📄 License

This project is open source. Each library may have its own specific license (check library README files).

## 🔗 Resources

- [OpenSCAD Documentation](https://openscad.org/documentation.html)
- [OpenSCAD Cheat Sheet](https://openscad.org/cheatsheet/)
- [Printables](https://www.printables.com/) - Share your makes!
- [Thingiverse](https://www.thingiverse.com/) - More 3D printing resources

## 📬 Support

- 🐛 **Bug Reports:** Open an issue on GitHub
- 💡 **Feature Requests:** Open an issue with the "enhancement" label
- 📖 **Documentation:** Check library-specific README files
- 🤔 **Questions:** Start a discussion on GitHub

---

**Happy Making! 🎉**
