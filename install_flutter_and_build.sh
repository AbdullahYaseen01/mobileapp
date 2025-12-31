#!/bin/bash

set -e

echo "========================================="
echo "Installing Flutter and Building App"
echo "========================================="
echo ""

# Install Flutter
echo "[1/3] Installing Flutter SDK..."
cd /tmp
wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.0-stable.tar.xz
tar xf flutter_linux_3.24.0-stable.tar.xz
export PATH="$PATH:/tmp/flutter/bin"

# Verify Flutter installation
echo "[2/3] Verifying Flutter installation..."
flutter --version
flutter doctor

# Go back to project directory
cd "$VERCEL_SOURCE_DIR" || cd "$(dirname "$0")/.."

# Enable web
echo "[3/3] Building Flutter web app..."
flutter config --enable-web

# Get dependencies
flutter pub get

# Build for web
flutter build web --release

echo ""
echo "========================================="
echo "Build Complete!"
echo "========================================="

