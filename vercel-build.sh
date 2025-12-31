#!/bin/bash
set -e

echo "========================================="
echo "Building Flutter Web for Vercel"
echo "========================================="

# Install Flutter if not available
if ! command -v flutter &> /dev/null; then
    echo "Installing Flutter..."
    cd /tmp
    wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz
    tar xf flutter_linux_3.24.0-stable.tar.xz
    export PATH="$PATH:/tmp/flutter/bin"
    cd -
fi

# Enable web
flutter config --enable-web

# Get dependencies
echo "Getting dependencies..."
flutter pub get

# Build
echo "Building web app..."
flutter build web --release

echo "Build complete!"

