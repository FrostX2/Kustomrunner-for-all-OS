#!/bin/bash

set -e

# Absolute project path (your real folder)
PROJECT_DIR="/mnt/mydisk/Kustomrunner"

# AppDir output inside installers/linux/appimage
APPDIR="$PROJECT_DIR/installers/linux/appimage/Kustomrunner.AppDir"

# Source code
SRC="$PROJECT_DIR/kustomrunner"

echo "[1/6] Cleaning old AppDir..."
rm -rf "$APPDIR"
mkdir -p "$APPDIR/usr/share/kustomrunner"

echo "[2/6] Copying kustomrunner source files..."
cp "$SRC/main.sh" "$APPDIR/usr/share/kustomrunner/main.sh"
cp "$SRC/config.json" "$APPDIR/usr/share/kustomrunner/config.json"
cp -r "$SRC/skins" "$APPDIR/usr/share/kustomrunner/"
cp -r "$SRC/plugins" "$APPDIR/usr/share/kustomrunner/"
cp -r "$SRC/utils" "$APPDIR/usr/share/kustomrunner/"

echo "[3/6] Installing AppRun..."
cp "$PROJECT_DIR/installers/linux/appimage/AppRun" "$APPDIR/"
chmod +x "$APPDIR/AppRun"

echo "[4/6] Installing desktop + icon..."
cp "$PROJECT_DIR/installers/linux/appimage/kustomrunner.desktop" "$APPDIR/"
cp "$PROJECT_DIR/installers/linux/appimage/kustomrunner.png" "$APPDIR/"

echo "[5/6] Checking for appimagetool..."
APPIMG_TOOL="$PROJECT_DIR/installers/linux/appimage/appimagetool-x86_64.AppImage"
if [ ! -f "$APPIMG_TOOL" ]; then
    echo "Downloading appimagetool..."
    wget -q https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O "$APPIMG_TOOL"
    chmod +x "$APPIMG_TOOL"
fi

echo "[6/6] Building AppImage..."
"$APPIMG_TOOL" "$APPDIR" "$PROJECT_DIR/Kustomrunner-x86_64.AppImage"

echo "---------------------------------------"
echo "AppImage built at:"
echo "$PROJECT_DIR/Kustomrunner-x86_64.AppImage"
echo "---------------------------------------"
