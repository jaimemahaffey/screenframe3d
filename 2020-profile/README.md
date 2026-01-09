# 2020 Aluminum Profile Accessories

🚧 **Status: In Development**

A collection of parametric connectors and accessories for 2020 aluminum extrusion profiles (20mm × 20mm T-slot aluminum).

## 🎯 Planned Features

### Clips and Cable Management
- [ ] Tube clips (various diameters)
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

## 🏗️ Project Structure (Planned)

```
2020-profile/
├── README.md                   # This file
├── config.scad                 # Global configuration
├── lib/
│   ├── profile_base.scad      # Base 2020 profile module
│   ├── clips.scad             # Clip library
│   ├── mounts.scad            # Mounting brackets
│   └── connectors.scad        # Structural connectors
├── print_tube_clip.scad       # Tube clip (various sizes)
├── print_planter_mount.scad   # Planter/pot mount
├── print_corner_bracket.scad  # 90° corner bracket
└── examples/
    └── sample_assembly.scad   # Example assemblies
```

## 🚀 Quick Start (Coming Soon)

1. Edit `config.scad` to set your profile dimensions
2. Choose the accessory you need
3. Customize parameters
4. Export and print!

## 🎨 Design Goals

### Parametric
All designs fully parametric - adjust for any profile size (2020, 2040, etc.)

### T-Slot Compatible
Properly sized for standard T-slot dimensions with adjustable tolerances

### Tool-Free Installation
Snap-fit or spring clip designs wherever possible

### Reusable
Common patterns extracted to shared library modules

## 💡 Use Cases

- **Grow Tents:** Planter mounts, tool holders, irrigation clips
- **Workbenches:** Tool organization, cable management
- **3D Printer Enclosures:** Spool holders, camera mounts, filters
- **Shelving Systems:** Brackets, panel clips, dividers
- **Robotics Frames:** Sensor mounts, wire management

## 🤝 Contributing

This library is in early development. Contributions and ideas welcome!

Planned development:
1. Base profile module with standard dimensions
2. Tube clip library (parametric diameters)
3. Planter mount system
4. Corner brackets and connectors

## 📚 Resources

- [80/20 Inc.](https://8020.net/) - T-slot framing systems
- [Misumi](https://us.misumi-ec.com/) - Aluminum extrusion supplier
- [OpenBuilds](https://openbuildspartstore.com/) - V-Slot aluminum extrusion

---

**Stay tuned for updates!** 🚧
