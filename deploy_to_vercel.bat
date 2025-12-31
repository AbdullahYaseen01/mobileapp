@echo off
echo =========================================
echo Deploy Study Planner to Vercel
echo =========================================
echo.

REM Check if Flutter is installed
where flutter >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter is not installed
    echo Please install Flutter first: https://flutter.dev
    pause
    exit /b 1
)

echo [1/3] Enabling Flutter Web...
flutter config --enable-web

echo.
echo [2/3] Building for web...
flutter build web --release

if %errorlevel% neq 0 (
    echo [ERROR] Build failed
    pause
    exit /b 1
)

echo.
echo [3/3] Build complete!
echo.
echo =========================================
echo Next Steps:
echo =========================================
echo.
echo Option 1: Deploy via Vercel Website (Easiest)
echo   1. Go to: https://vercel.com/new
echo   2. Import GitHub: AbdullahYaseen01/mobileapp
echo   3. Settings:
echo      - Framework: Other
echo      - Build Command: flutter build web --release
echo      - Output Directory: build/web
echo   4. Click Deploy!
echo.
echo Option 2: Deploy via Vercel CLI
echo   1. Install: npm i -g vercel
echo   2. Run: vercel --prod
echo.
echo Your app will be live at: https://your-app.vercel.app
echo.
pause

