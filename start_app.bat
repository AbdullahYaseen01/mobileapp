@echo off
echo ========================================
echo Study Planner - Starting App
echo ========================================
echo.

REM Check if Flutter is installed
where flutter >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter is not installed or not in PATH
    echo.
    echo Please install Flutter first:
    echo 1. Download from: https://flutter.dev/docs/get-started/install/windows
    echo 2. Extract to a folder (e.g., C:\src\flutter)
    echo 3. Add to PATH: C:\src\flutter\bin
    echo 4. Restart this terminal
    echo.
    pause
    exit /b 1
)

echo [OK] Flutter found!
flutter --version
echo.

REM Check if we're in the right directory
if not exist "pubspec.yaml" (
    echo [ERROR] pubspec.yaml not found. Please run this script from the project root.
    pause
    exit /b 1
)

echo [1/5] Creating Flutter project structure (if needed)...
if not exist ".dart_tool" (
    flutter create . --platforms=android,ios
)
echo.

echo [2/5] Installing dependencies...
flutter pub get
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)
echo [OK] Dependencies installed!
echo.

echo [3/5] Checking Firebase configuration...
set FIREBASE_OK=1

if not exist "android\app\google-services.json" (
    echo [WARNING] google-services.json not found in android\app\
    echo           You need to download this from Firebase Console
    set FIREBASE_OK=0
) else (
    echo [OK] google-services.json found
)

if not exist "ios\Runner\GoogleService-Info.plist" (
    echo [WARNING] GoogleService-Info.plist not found in ios\Runner\
    echo           You need to download this from Firebase Console (if building for iOS)
) else (
    echo [OK] GoogleService-Info.plist found
)

if %FIREBASE_OK%==0 (
    echo.
    echo [WARNING] Firebase is not fully configured!
    echo           The app may not work without Firebase setup.
    echo           See FIREBASE_SETUP_AUTOMATED.md for instructions.
    echo.
    choice /C YN /M "Continue anyway"
    if errorlevel 2 exit /b 0
)
echo.

echo [4/5] Running Flutter doctor...
flutter doctor
echo.

echo [5/5] Checking for connected devices...
flutter devices
echo.

echo ========================================
echo Starting the app...
echo ========================================
echo.

REM Try to run the app
flutter run

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to start the app
    echo.
    echo Common issues:
    echo - No device/emulator connected (run: flutter devices)
    echo - Firebase not configured (see FIREBASE_SETUP_AUTOMATED.md)
    echo - Build errors (run: flutter clean, then flutter pub get)
    echo.
    pause
)


