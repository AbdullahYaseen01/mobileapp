@echo off
echo ========================================
echo Study Planner - Setup and Run Script
echo ========================================
echo.

echo Step 1: Checking Flutter installation...
flutter --version
if %errorlevel% neq 0 (
    echo ERROR: Flutter is not installed or not in PATH
    echo Please install Flutter from: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)
echo Flutter found!
echo.

echo Step 2: Creating Flutter project structure...
flutter create .
if %errorlevel% neq 0 (
    echo WARNING: Flutter create failed. Project might already exist.
)
echo.

echo Step 3: Installing dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)
echo Dependencies installed!
echo.

echo Step 4: Checking Firebase configuration...
if not exist "android\app\google-services.json" (
    echo WARNING: google-services.json not found!
    echo Please download from Firebase Console and place in android\app\
    echo See FIREBASE_SETUP_AUTOMATED.md for instructions
) else (
    echo google-services.json found!
)

if not exist "ios\Runner\GoogleService-Info.plist" (
    echo WARNING: GoogleService-Info.plist not found!
    echo Please download from Firebase Console and place in ios\Runner\
    echo See FIREBASE_SETUP_AUTOMATED.md for instructions
) else (
    echo GoogleService-Info.plist found!
)
echo.

echo Step 5: Running Flutter doctor...
flutter doctor
echo.

echo ========================================
echo Setup Complete!
echo.
echo Next steps:
echo 1. Set up Firebase (see FIREBASE_SETUP_AUTOMATED.md)
echo 2. Add google-services.json and GoogleService-Info.plist
echo 3. Run: flutter run
echo ========================================
pause


