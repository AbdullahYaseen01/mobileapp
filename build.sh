#!/bin/bash

set -e

echo "Installing Flutter SDK..."

# Download and install Flutter
cd /tmp
FLUTTER_VERSION="3.24.0"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

if [ ! -d "flutter" ]; then
    echo "Downloading Flutter..."
    wget -q "$FLUTTER_URL" -O flutter.tar.xz
    tar xf flutter.tar.xz
    rm flutter.tar.xz
fi

# Add Flutter to PATH
export PATH="$PATH:/tmp/flutter/bin"

# Verify installation
flutter --version

# Go to project directory
cd "$VERCEL_SOURCE_DIR" || cd "$(pwd)"

# Enable web
flutter config --enable-web

# Get dependencies
echo "Getting Flutter dependencies..."
flutter pub get

# Build for web
echo "Building Flutter web app..."
flutter build web --release

echo "Build completed successfully!"

