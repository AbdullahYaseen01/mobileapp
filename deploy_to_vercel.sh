#!/bin/bash

echo "========================================="
echo "Deploy Study Planner to Vercel"
echo "========================================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "ERROR: Flutter is not installed"
    echo "Please install Flutter first: https://flutter.dev"
    exit 1
fi

echo "Step 1: Enabling Flutter Web..."
flutter config --enable-web

echo ""
echo "Step 2: Building for web..."
flutter build web --release

if [ $? -ne 0 ]; then
    echo "ERROR: Build failed"
    exit 1
fi

echo ""
echo "Step 3: Build complete!"
echo ""
echo "Next steps:"
echo "1. Go to: https://vercel.com/new"
echo "2. Import GitHub repository: AbdullahYaseen01/mobileapp"
echo "3. Settings:"
echo "   - Framework: Other"
echo "   - Build Command: flutter build web --release"
echo "   - Output Directory: build/web"
echo "4. Click Deploy!"
echo ""
echo "Or use Vercel CLI:"
echo "  npm i -g vercel"
echo "  vercel --prod"
echo ""

