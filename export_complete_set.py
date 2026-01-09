#!/usr/bin/env python3
"""
Complete Set 3MF Exporter
Generates 3MF files with all parts needed for your screen frame configuration
"""

import subprocess
import sys
import os
import re
from pathlib import Path

# ANSI colors
class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    CYAN = '\033[0;36m'
    NC = '\033[0m'  # No Color

def print_header(text):
    print(f"{Colors.BLUE}{'=' * 50}{Colors.NC}")
    print(f"{Colors.BLUE}{text:^50}{Colors.NC}")
    print(f"{Colors.BLUE}{'=' * 50}{Colors.NC}")

def print_success(text):
    print(f"{Colors.GREEN}✓{Colors.NC} {text}")

def print_warning(text):
    print(f"{Colors.YELLOW}⚠{Colors.NC}  {text}")

def print_error(text):
    print(f"{Colors.RED}✗{Colors.NC} {text}")

def print_info(text):
    print(f"{Colors.CYAN}ℹ{Colors.NC}  {text}")

def check_openscad():
    """Check if OpenSCAD is installed"""
    try:
        result = subprocess.run(['openscad', '--version'],
                              capture_output=True, text=True, timeout=5)
        return True
    except (subprocess.SubprocessError, FileNotFoundError):
        return False

def parse_config():
    """Parse config.scad to get grid dimensions"""
    config_file = Path('config.scad')
    if not config_file.exists():
        print_error("config.scad not found!")
        sys.exit(1)

    with open(config_file, 'r') as f:
        content = f.read()

    # Extract grid dimensions
    grid_x_match = re.search(r'GRID_CELLS_X\s*=\s*(\d+)', content)
    grid_y_match = re.search(r'GRID_CELLS_Y\s*=\s*(\d+)', content)

    if not grid_x_match or not grid_y_match:
        print_error("Could not parse GRID_CELLS_X/Y from config.scad")
        sys.exit(1)

    grid_x = int(grid_x_match.group(1))
    grid_y = int(grid_y_match.group(1))

    return {
        'grid_x': grid_x,
        'grid_y': grid_y,
        'total_cells': grid_x * grid_y
    }

def export_3mf(scad_file, output_file, description=""):
    """Export a SCAD file to 3MF"""
    print(f"\n{Colors.YELLOW}Generating:{Colors.NC} {output_file}")
    if description:
        print_info(description)

    try:
        result = subprocess.run(
            ['openscad', '-o', output_file, '--export-format', '3mf', scad_file],
            capture_output=True,
            text=True,
            timeout=120
        )

        if result.returncode == 0 and Path(output_file).exists():
            size = Path(output_file).stat().st_size
            size_mb = size / (1024 * 1024)
            print_success(f"Created: {output_file} ({size_mb:.2f} MB)")
            return True
        else:
            print_error(f"Failed to create {output_file}")
            if result.stderr:
                print(f"  Error: {result.stderr[:200]}")
            return False
    except subprocess.TimeoutExpired:
        print_error(f"Timeout generating {output_file}")
        return False
    except Exception as e:
        print_error(f"Error: {str(e)}")
        return False

def create_multi_part_scad(part_type, count, output_scad):
    """Create a SCAD file with multiple parts arranged"""
    spacing = 10  # mm between parts
    parts_per_row = 2  # Arrange in 2x2 grid max for typical bed

    if part_type == "base":
        module_name = "base_frame_cell"
        include_file = "lib/base_frame.scad"
    else:
        module_name = "top_frame_cell"
        include_file = "lib/top_frame.scad"

    scad_content = f"""// Auto-generated multi-part layout
include <config.scad>
use <{include_file}>

// Generate {count} {part_type} frame cells
spacing = {spacing};
cell_size = CELL_WIDTH + CONNECTOR_PIN_LENGTH;

for (i = [0:{count-1}]) {{
    row = floor(i / {parts_per_row});
    col = i % {parts_per_row};
    x_pos = col * (cell_size + spacing);
    y_pos = row * (cell_size + spacing);

    translate([x_pos, y_pos, 0])
        {module_name}();
}}

echo("Generated {count} {part_type} frame cells");
"""

    with open(output_scad, 'w') as f:
        f.write(scad_content)

    return output_scad

def main():
    print_header("Screen Frame 3MF Exporter")
    print()

    # Check OpenSCAD
    if not check_openscad():
        print_error("OpenSCAD not found!")
        print("Install OpenSCAD:")
        print("  • Ubuntu/Debian: sudo apt install openscad")
        print("  • Mac: brew install openscad")
        print("  • Windows: Download from openscad.org")
        sys.exit(1)

    print_success("OpenSCAD found")

    # Parse configuration
    print("\nReading configuration...")
    config = parse_config()
    print_info(f"Grid size: {config['grid_x']}×{config['grid_y']}")
    print_info(f"Total cells needed: {config['total_cells']}")

    # Create output directory
    output_dir = Path('output')
    output_dir.mkdir(exist_ok=True)
    print_success(f"Output directory: {output_dir}")

    # Export individual parts
    print(f"\n{Colors.BLUE}{'─' * 50}{Colors.NC}")
    print(f"{Colors.BLUE}Exporting Individual Parts{Colors.NC}")
    print(f"{Colors.BLUE}{'─' * 50}{Colors.NC}")

    success_count = 0

    # Single base frame
    if export_3mf('print_base_frame.scad',
                  str(output_dir / 'base_frame_single.3mf'),
                  f"Single base frame cell (print {config['total_cells']}×)"):
        success_count += 1

    # Single top frame
    if export_3mf('print_top_frame.scad',
                  str(output_dir / 'top_frame_single.3mf'),
                  f"Single top frame cell (print {config['total_cells']}×)"):
        success_count += 1

    # Connector test
    if export_3mf('test_connector_fit.scad',
                  str(output_dir / 'connector_test.3mf'),
                  "Test print for connector fit verification"):
        success_count += 1

    # Generate complete sets if needed
    if config['total_cells'] <= 4:  # Only for small builds that fit on plate
        print(f"\n{Colors.BLUE}{'─' * 50}{Colors.NC}")
        print(f"{Colors.BLUE}Generating Complete Build Plates{Colors.NC}")
        print(f"{Colors.BLUE}{'─' * 50}{Colors.NC}")

        # All base frames
        temp_base = output_dir / '_temp_all_base_frames.scad'
        create_multi_part_scad('base', config['total_cells'], temp_base)
        if export_3mf(str(temp_base),
                     str(output_dir / 'all_base_frames.3mf'),
                     f"Complete set of {config['total_cells']} base frames"):
            success_count += 1
        temp_base.unlink(missing_ok=True)

        # All top frames
        temp_top = output_dir / '_temp_all_top_frames.scad'
        create_multi_part_scad('top', config['total_cells'], temp_top)
        if export_3mf(str(temp_top),
                     str(output_dir / 'all_top_frames.3mf'),
                     f"Complete set of {config['total_cells']} top frames"):
            success_count += 1
        temp_top.unlink(missing_ok=True)

    else:
        print_warning(f"Grid too large ({config['total_cells']} cells) for single build plate")
        print_info("Use single part 3MFs and multiply in your slicer")

    # Summary
    print(f"\n{Colors.BLUE}{'=' * 50}{Colors.NC}")
    print_success(f"Export complete! {success_count} files generated")
    print()
    print(f"{Colors.CYAN}Files created in:{Colors.NC} {output_dir}/")
    print()
    print(f"{Colors.BLUE}Next Steps:{Colors.NC}")
    print("  1. Import 3MF files into Bambu Studio / OrcaSlicer")
    print(f"  2. Print {config['total_cells']}× base frames")
    print(f"  3. Print {config['total_cells']}× top frames")
    print("  4. Assemble your screen frame!")
    print()

if __name__ == '__main__':
    main()
