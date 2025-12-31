# Quick Start Guide - Study Planner App

## 🚀 To Start the App Right Now

### Option 1: Automated Script (Recommended)
```bash
# Just double-click or run:
start_app.bat
```

### Option 2: Manual Steps

```bash
# 1. Install dependencies
flutter pub get

# 2. Check setup
flutter doctor

# 3. List available devices
flutter devices

# 4. Run the app
flutter run
```

## ⚠️ Prerequisites

### 1. Install Flutter (Required)

**Windows:**
1. Download Flutter SDK: https://flutter.dev/docs/get-started/install/windows
2. Extract to `C:\src\flutter` (or any location)
3. Add to PATH:
   - Search "Environment Variables" in Windows
   - Edit "Path" variable
   - Add: `C:\src\flutter\bin`
   - Restart terminal
4. Verify: `flutter doctor`

### 2. Set Up Firebase (Required for app to work)

**Quick Steps:**
1. Go to: https://console.firebase.google.com/
2. Create new project: "Study Planner"
3. Add Android app:
   - Package: `com.example.study_planner`
   - Download `google-services.json`
   - Place in: `android/app/google-services.json`
4. Enable Authentication (Email/Password)
5. Enable Firestore Database
6. Add security rules (see SETUP_GUIDE.md)

## 📱 Running the App

### On Android Emulator:
```bash
# Start emulator first, then:
flutter run
```

### On Physical Device:
```bash
# Enable USB debugging on your phone
# Connect via USB
flutter devices  # Should show your device
flutter run
```

### On iOS (Mac only):
```bash
# Open iOS Simulator first, then:
flutter run
```

## 🔧 Troubleshooting

### "Flutter not found"
- Install Flutter SDK
- Add to PATH
- Restart terminal

### "No devices found"
- Start Android Studio emulator
- Or connect physical device with USB debugging
- Run `flutter devices` to verify

### "Firebase initialization error"
- Check `google-services.json` is in `android/app/`
- Verify Firebase services are enabled
- Check package name matches Firebase

### Build Errors
```bash
flutter clean
flutter pub get
flutter run
```

## ✅ Success Indicators

When the app starts successfully, you should see:
- Login screen appears
- No Firebase errors in console
- App runs smoothly

## 📞 Need Help?

- See `SETUP_STATUS.md` for current status
- See `FIREBASE_SETUP_AUTOMATED.md` for Firebase details
- See `SETUP_GUIDE.md` for complete setup guide


