#!/bin/bash
# Release script for rapidchart-mcp
# Usage: ./release.sh

set -e  # Exit on error

echo "🚀 Building and releasing rapidchart-mcp..."
echo ""

# Get version from pyproject.toml
VERSION=$(grep '^version = ' pyproject.toml | cut -d'"' -f2)
echo "📌 Current version: $VERSION"
echo ""

# Confirm release
read -p "Release version $VERSION to PyPI? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Release cancelled"
    exit 1
fi

echo ""

# Clean old builds
echo "🧹 Cleaning old builds..."
rm -rf dist/ build/ src/*.egg-info
echo "✓ Cleaned"
echo ""

# Build
echo "📦 Building package..."
python -m build
echo "✓ Built"
echo ""

# Validate
echo "✅ Validating package..."
python -m twine check dist/*
echo "✓ Valid"
echo ""

# Upload
echo "📤 Uploading to PyPI..."
python -m twine upload dist/*
echo ""

echo "╔═══════════════════════════════════════════════════════╗"
echo "║                                                       ║"
echo "║  ✨ Release $VERSION complete! ✨                    "
echo "║                                                       ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo ""
echo "📦 View at: https://pypi.org/project/rapidchart-mcp/"
echo "💾 Install with: pip install --upgrade rapidchart-mcp"
echo ""

