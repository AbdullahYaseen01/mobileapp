# Flutter Project Setup Instructions

## Step 1: Install Flutter (if not installed)

1. Download Flutter SDK from: https://flutter.dev/docs/get-started/install
2. Extract to a location (e.g., `C:\src\flutter`)
3. Add Flutter to PATH:
   - Open System Environment Variables
   - Add `C:\src\flutter\bin` to PATH
   - Restart terminal

## Step 2: Verify Flutter Installation

```bash
flutter doctor
```

## Step 3: Create Flutter Project Structure

Since we already have the `lib/` folder, we need to create the full Flutter project structure.

**Option A: Create new project and copy files**
```bash
flutter create study_planner
# Then copy our lib/ folder and pubspec.yaml
```

**Option B: Initialize in current directory**
```bash
flutter create .
```

## Step 4: Install Dependencies

```bash
flutter pub get
```

## Step 5: Firebase Setup

Follow the instructions in `SETUP_GUIDE.md` to:
1. Create Firebase project
2. Add Android/iOS apps
3. Download config files
4. Enable services

## Step 6: Run the App

```bash
flutter run
```


