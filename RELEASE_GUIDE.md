# Release Guide for rapidchart-mcp

This guide explains how to release new versions of the rapidchart-mcp package to PyPI.

## Quick Release Process

### 1. Update Version Number

Edit `pyproject.toml` and bump the version:

```toml
[project]
name = "rapidchart_mcp"
version = "0.1.1"  # ← Change this!
```

**Version Numbering (Semantic Versioning):**
- **Patch** (0.1.1 → 0.1.2): Bug fixes, small changes
- **Minor** (0.1.0 → 0.2.0): New features, backward compatible
- **Major** (0.2.0 → 1.0.0): Breaking changes

### 2. Build and Upload

```bash
cd /Users/samirib/Documents/Final_Project/rapidchart-mcp

# Clean old builds
rm -rf dist/ build/ src/*.egg-info

# Build the package
python -m build

# Validate the build (optional but recommended)
python -m twine check dist/*

# Upload to PyPI
python -m twine upload dist/*
```

### 3. Verify Release

After upload succeeds:

```bash
# Check it's live
pip index versions rapidchart-mcp

# Test installation in a fresh environment
pip install --upgrade rapidchart-mcp
```

View on PyPI: https://pypi.org/project/rapidchart-mcp/

---

## Using the Release Script

For convenience, use the `release.sh` script:

```bash
# Make it executable (first time only)
chmod +x release.sh

# Run the release
./release.sh
```

The script will:
1. Clean old builds
2. Build the package
3. Validate it
4. Upload to PyPI

---

## Automated Release Script

Create `release.sh` in the project root:

```bash
#!/bin/bash
# Release script for rapidchart-mcp

set -e  # Exit on error

echo "🚀 Building and releasing rapidchart-mcp..."

# Get version from pyproject.toml
VERSION=$(grep '^version = ' pyproject.toml | cut -d'"' -f2)
echo "Version: $VERSION"

# Confirm release
read -p "Release version $VERSION to PyPI? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Release cancelled"
    exit 1
fi

# Clean old builds
echo "🧹 Cleaning old builds..."
rm -rf dist/ build/ src/*.egg-info

# Build
echo "📦 Building package..."
python -m build

# Validate
echo "✅ Validating package..."
python -m twine check dist/*

# Upload
echo "📤 Uploading to PyPI..."
python -m twine upload dist/*

echo ""
echo "✨ Release $VERSION complete!"
echo "📦 View at: https://pypi.org/project/rapidchart-mcp/"
echo "💾 Install with: pip install --upgrade rapidchart-mcp"
```

---

## Pre-Release Checklist

Before releasing, make sure:

- [ ] Version number is updated in `pyproject.toml`
- [ ] All tests pass
- [ ] README.md is up to date
- [ ] CHANGELOG is updated (if you have one)
- [ ] Changes are committed to git
- [ ] You've tested locally with `pip install -e .`

---

## First-Time Setup (Already Done)

Your PyPI credentials are already configured in `~/.pypirc`:

```ini
[pypi]
username = __token__
password = pypi-YOUR_TOKEN_HERE
```

If you need to update your token, just edit that file.

---

## Troubleshooting

### Error: File already exists

You can't upload the same version twice. Bump the version number in `pyproject.toml`.

### Error: Invalid distribution metadata

Run `python -m twine check dist/*` to see what's wrong.

### Error: Authentication failed

Check your `~/.pypirc` file has the correct PyPI token.

### Test on Test PyPI First

For major releases, test on Test PyPI first:

```bash
# Upload to Test PyPI
python -m twine upload --repository testpypi dist/*

# Test install
pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ rapidchart-mcp
```

---

## Updating Dependencies

If you update dependencies in `pyproject.toml`:

```toml
dependencies = [
    "mcp>=0.9.0",
    "httpx>=0.27.0",
    "pydantic>=2.0.0",
    "new-package>=1.0.0",  # ← Add new dependencies
]
```

Then follow the normal release process.

---

## GitHub Integration (Optional)

Consider creating a GitHub Action to automate releases:

1. Tag a release on GitHub: `git tag v0.1.1 && git push --tags`
2. GitHub Action builds and publishes automatically

---

## Resources

- **PyPI Package:** https://pypi.org/project/rapidchart-mcp/
- **PyPI Help:** https://pypi.org/help/
- **Python Packaging Guide:** https://packaging.python.org/
- **Semantic Versioning:** https://semver.org/

---

## Quick Reference

```bash
# Full release in one go
rm -rf dist/ build/ && python -m build && python -m twine upload dist/*

# Just build (no upload)
python -m build

# Just check (no upload)
python -m twine check dist/*

# Check installed version
pip show rapidchart-mcp

# Uninstall
pip uninstall rapidchart-mcp
```

