#!/usr/bin/env python3
"""
Generic 3MF Library Exporter
Exports 3MF files for any library in the SCAD Toolkit
"""

import subprocess
import sys
import os
import argparse
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
    print(f"{Colors.BLUE}{'=' * 60}{Colors.NC}")
    print(f"{Colors.BLUE}{text:^60}{Colors.NC}")
    print(f"{Colors.BLUE}{'=' * 60}{Colors.NC}")

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

def export_3mf(scad_file, output_file, description=""):
    """Export a SCAD file to 3MF"""
    print(f"\n{Colors.YELLOW}Generating:{Colors.NC} {output_file.name}")
    if description:
        print_info(description)

    try:
        result = subprocess.run(
            ['openscad', '-o', str(output_file), '--export-format', '3mf', str(scad_file)],
            capture_output=True,
            text=True,
            timeout=120,
            cwd=scad_file.parent
        )

        if result.returncode == 0 and output_file.exists():
            size = output_file.stat().st_size
            size_mb = size / (1024 * 1024)
            print_success(f"Created: {output_file.name} ({size_mb:.2f} MB)")
            return True
        else:
            print_error(f"Failed to create {output_file.name}")
            if result.stderr:
                print(f"  Error: {result.stderr[:200]}")
            return False
    except subprocess.TimeoutExpired:
        print_error(f"Timeout generating {output_file.name}")
        return False
    except Exception as e:
        print_error(f"Error: {str(e)}")
        return False

def export_library(library_path, output_dir=None):
    """Export all printable files from a library"""
    library_path = Path(library_path)

    if not library_path.exists():
        print_error(f"Library not found: {library_path}")
        return False

    # Find all print_*.scad files
    print_files = list(library_path.glob("print_*.scad"))
    test_files = list(library_path.glob("test_*.scad"))

    if not print_files and not test_files:
        print_warning(f"No exportable files found in {library_path.name}")
        print_info("Looking for files matching: print_*.scad or test_*.scad")
        return False

    # Setup output directory
    if output_dir is None:
        output_dir = library_path / "output"
    else:
        output_dir = Path(output_dir)

    output_dir.mkdir(parents=True, exist_ok=True)
    print_success(f"Output directory: {output_dir}")

    success_count = 0
    total_count = len(print_files) + len(test_files)

    # Export print files
    for scad_file in print_files:
        output_file = output_dir / f"{scad_file.stem}.3mf"
        if export_3mf(scad_file, output_file):
            success_count += 1

    # Export test files
    for scad_file in test_files:
        output_file = output_dir / f"{scad_file.stem}.3mf"
        if export_3mf(scad_file, output_file, "Test/calibration print"):
            success_count += 1

    return success_count, total_count

def main():
    parser = argparse.ArgumentParser(
        description='Export 3MF files from SCAD Toolkit libraries',
        epilog='Example: ./export_library.py modular-screen-frame'
    )
    parser.add_argument('library', help='Library directory to export (e.g., modular-screen-frame)')
    parser.add_argument('-o', '--output', help='Output directory (default: library/output)')
    parser.add_argument('--all', action='store_true', help='Export all libraries')

    args = parser.parse_args()

    print_header("SCAD Toolkit - Library Exporter")
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
    print()

    # Get script directory (scripts/) and project root
    script_dir = Path(__file__).parent
    project_root = script_dir.parent

    if args.all:
        # Export all libraries
        libraries = [d for d in project_root.iterdir()
                    if d.is_dir() and d.name not in ['common', 'scripts', '.git', 'output']]

        if not libraries:
            print_error("No libraries found to export")
            sys.exit(1)

        print_info(f"Found {len(libraries)} libraries")
        print()

        total_success = 0
        total_files = 0

        for lib in libraries:
            print(f"\n{Colors.CYAN}{'─' * 60}{Colors.NC}")
            print(f"{Colors.CYAN}Exporting: {lib.name}{Colors.NC}")
            print(f"{Colors.CYAN}{'─' * 60}{Colors.NC}")

            success, total = export_library(lib, args.output)
            total_success += success
            total_files += total

        print(f"\n{Colors.BLUE}{'=' * 60}{Colors.NC}")
        print_success(f"Export complete! {total_success}/{total_files} files generated")

    else:
        # Export single library
        library_path = project_root / args.library

        print_info(f"Exporting library: {args.library}")
        print()

        success_count, total_count = export_library(library_path, args.output)

        print(f"\n{Colors.BLUE}{'=' * 60}{Colors.NC}")
        if success_count > 0:
            print_success(f"Export complete! {success_count}/{total_count} files generated")
            print()
            print(f"{Colors.CYAN}Next Steps:{Colors.NC}")
            print("  1. Import 3MF files into your slicer")
            print("  2. Adjust print settings as needed")
            print("  3. Print!")
        else:
            print_error("Export failed")
            sys.exit(1)

    print()

if __name__ == '__main__':
    main()
