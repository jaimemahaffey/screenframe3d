#!/bin/bash
# =====================================================
# Generate 3MF Files for Screen Frame Parts
# =====================================================
# This script exports 3MF files ready for slicing
# 3MF format includes metadata and is Bambu Studio friendly

set -e  # Exit on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}Screen Frame 3MF Generator${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""

# Check if OpenSCAD is installed
if ! command -v openscad &> /dev/null; then
    echo -e "${RED}Error: OpenSCAD not found!${NC}"
    echo "Please install OpenSCAD:"
    echo "  - Ubuntu/Debian: sudo apt install openscad"
    echo "  - Mac: brew install openscad"
    echo "  - Windows: Download from openscad.org"
    exit 1
fi

# Create output directory
OUTPUT_DIR="output"
mkdir -p "$OUTPUT_DIR"

echo -e "${GREEN}✓${NC} Output directory: $OUTPUT_DIR"
echo ""

# Function to export 3MF
export_3mf() {
    local input_file=$1
    local output_name=$2

    echo -e "${YELLOW}Generating:${NC} $output_name.3mf"

    openscad -o "$OUTPUT_DIR/$output_name.3mf" \
             --export-format 3mf \
             "$input_file" \
             2>&1 | grep -i "warning\|error" || true

    if [ -f "$OUTPUT_DIR/$output_name.3mf" ]; then
        local size=$(du -h "$OUTPUT_DIR/$output_name.3mf" | cut -f1)
        echo -e "${GREEN}✓${NC} Created: $output_name.3mf ($size)"
    else
        echo -e "${RED}✗${NC} Failed to create: $output_name.3mf"
        return 1
    fi
    echo ""
}

# Export individual parts
echo -e "${BLUE}Exporting individual parts...${NC}"
echo ""

export_3mf "print_base_frame.scad" "base_frame_cell"
export_3mf "print_top_frame.scad" "top_frame_cell"
export_3mf "test_connector_fit.scad" "connector_test"

# Export connectors if they exist
if [ -f "print_connectors.scad" ]; then
    export_3mf "print_connectors.scad" "spare_connectors"
fi

echo -e "${BLUE}=====================================${NC}"
echo -e "${GREEN}✓ Export complete!${NC}"
echo ""
echo -e "${YELLOW}Files created in:${NC} $OUTPUT_DIR/"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Import 3MF files into your slicer (Bambu Studio, OrcaSlicer, etc.)"
echo "2. Multiply the parts as needed for your grid size"
echo "3. Arrange on build plate"
echo "4. Slice and print!"
echo ""
echo -e "${YELLOW}Tip:${NC} Check config.scad to see how many of each part you need"
echo ""
