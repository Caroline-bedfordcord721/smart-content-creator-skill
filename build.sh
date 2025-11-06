#!/bin/bash
# Build script for Smart Content Creator skill
# This script packages the source files into a .skill file (ZIP archive)

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Building Smart Content Creator skill...${NC}"

# Determine directory name based on what exists
if [ -d "src/smart-content-creator" ]; then
    SRC_DIR="smart-content-creator"
    SKILL_NAME="smart-content-creator"
else
    echo "Error: Source directory not found. Expected src/smart-content-creator/"
    exit 1
fi

# Check if src directory exists
if [ ! -d "src/$SRC_DIR" ]; then
    echo "Error: src/$SRC_DIR directory not found"
    exit 1
fi

# Create a temporary build directory
BUILD_DIR=$(mktemp -d)
echo "Using temporary directory: $BUILD_DIR"

# Copy source files to build directory
cp -r "src/$SRC_DIR" "$BUILD_DIR/"

# Change to build directory and create the archive
cd "$BUILD_DIR"
zip -r "${SKILL_NAME}.skill" "$SRC_DIR/" -q

# Move the built file back to project root
mv "${SKILL_NAME}.skill" "$OLDPWD/"

# Clean up
cd "$OLDPWD"
rm -rf "$BUILD_DIR"

# Show file size and contents
echo -e "${GREEN}✓ Build successful!${NC}"
echo ""
echo "Output: ${SKILL_NAME}.skill"
echo "Size: $(ls -lh ${SKILL_NAME}.skill | awk '{print $5}')"
echo ""
echo "Contents:"
unzip -l "${SKILL_NAME}.skill"

echo ""
echo -e "${GREEN}Skill package is ready for distribution!${NC}"
echo ""
echo -e "${BLUE}To test:${NC}"
echo "  1. Open Claude Desktop or visit claude.ai"
echo "  2. Go to Settings → Skills"
echo "  3. Import the ${SKILL_NAME}.skill file"
echo ""

