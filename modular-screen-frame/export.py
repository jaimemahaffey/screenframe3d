#!/usr/bin/env python3
"""
Modular Screen Frame - Export Script
Wrapper around the shared export script
"""

import sys
from pathlib import Path

# Add scripts directory to path
scripts_dir = Path(__file__).parent.parent / "scripts"
sys.path.insert(0, str(scripts_dir))

# Import and run the generic exporter
from export_library import export_library, print_header, print_success, check_openscad, Colors

def main():
    print_header("Modular Screen Frame - 3MF Exporter")
    print()

    if not check_openscad():
        print(f"{Colors.RED}✗{Colors.NC} OpenSCAD not found!")
        print("Install from: https://openscad.org/downloads.html")
        sys.exit(1)

    library_path = Path(__file__).parent
    success, total = export_library(library_path)

    if success > 0:
        print(f"\n{Colors.GREEN}✓{Colors.NC} Export complete! {success}/{total} files generated")
        print(f"\n{Colors.CYAN}Files are in:{Colors.NC} output/")
        print(f"\n{Colors.BLUE}Next Steps:{Colors.NC}")
        print("  1. Import 3MF files into Bambu Studio / OrcaSlicer")
        print("  2. Print according to your config.scad settings")
        print("  3. Assemble your screen frame!")
    else:
        print(f"{Colors.RED}✗{Colors.NC} Export failed")
        sys.exit(1)

if __name__ == '__main__':
    main()
