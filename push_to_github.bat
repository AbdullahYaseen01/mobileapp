@echo off
echo ========================================
echo Push Study Planner to GitHub
echo ========================================
echo.

REM Check if GitHub CLI is installed
where gh >nul 2>&1
if %errorlevel% equ 0 (
    echo [OPTION 1] Using GitHub CLI
    echo.
    echo Creating repository and pushing...
    gh repo create study-planner --public --source=. --remote=origin --push
    if %errorlevel% equ 0 (
        echo.
        echo [SUCCESS] Repository created and pushed!
        echo.
        gh repo view --web
        exit /b 0
    ) else (
        echo [INFO] GitHub CLI method failed, trying manual method...
        echo.
    )
)

echo [OPTION 2] Manual Push Instructions
echo.
echo Step 1: Create a new repository on GitHub
echo    Go to: https://github.com/new
echo    Name: study-planner
echo    Description: Flutter Study Planner App with Firebase
echo    Choose Public
echo    DO NOT initialize with README
echo    Click "Create repository"
echo.
echo Step 2: Copy the repository URL from GitHub
echo    It will look like: https://github.com/YOUR_USERNAME/study-planner.git
echo.
set /p REPO_URL="Enter your GitHub repository URL: "

if "%REO_URL%"=="" (
    echo [ERROR] No URL provided
    pause
    exit /b 1
)

echo.
echo Step 3: Adding remote and pushing...
git remote add origin %REPO_URL% 2>nul
git remote set-url origin %REPO_URL% 2>nul
git branch -M main
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] Code pushed to GitHub!
    echo.
    echo Your repository is now available at:
    echo %REPO_URL%
    echo.
    echo You can view it online and share with others!
) else (
    echo.
    echo [ERROR] Failed to push. Common issues:
    echo - Repository URL incorrect
    echo - Not authenticated with GitHub
    echo - Repository already exists with different content
    echo.
    echo Try:
    echo 1. Create repository on GitHub first
    echo 2. Use the HTTPS URL
    echo 3. Authenticate: git config --global credential.helper wincred
)

pause

