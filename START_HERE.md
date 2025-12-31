# 🚀 START HERE - How to Run the Study Planner App

## Current Status

✅ **Project Code:** 100% Complete (27 Dart files)
✅ **Project Structure:** Complete
✅ **Configuration Files:** Complete
❌ **Flutter SDK:** Not Installed (Required)
❌ **Firebase Setup:** Not Done (Required)

## ⚡ Quick Start (3 Steps)

### Step 1: Install Flutter (5 minutes)

1. **Download Flutter:**
   - Go to: https://flutter.dev/docs/get-started/install/windows
   - Click "Download Flutter SDK"
   - Extract ZIP to `C:\src\flutter` (create folder if needed)

2. **Add to PATH:**
   - Press `Win + R`, type `sysdm.cpl`, press Enter
   - Click "Environment Variables"
   - Under "User variables", find "Path", click "Edit"
   - Click "New", add: `C:\src\flutter\bin`
   - Click OK on all dialogs

3. **Verify:**
   - Close and reopen PowerShell/Terminal
   - Run: `flutter doctor`
   - You should see Flutter version info

### Step 2: Install Dependencies (1 minute)

Open PowerShell in this folder (`d:\mobileapp`) and run:

```powershell
flutter pub get
```

### Step 3: Run the App (1 minute)

```powershell
# Option A: Use the automated script
.\start_app.bat

# Option B: Manual
flutter run
```

## 📱 Before Running - Set Up Firebase

The app **requires Firebase** to work. Quick setup:

1. **Create Firebase Project:**
   - Go to: https://console.firebase.google.com/
   - Click "Add project" → Name: "Study Planner"
   - Follow wizard (disable Analytics if you want)

2. **Add Android App:**
   - Click Android icon
   - Package name: `com.example.study_planner`
   - Download `google-services.json`
   - **Save to:** `android\app\google-services.json`

3. **Enable Services:**
   - **Authentication:** Enable Email/Password
   - **Firestore:** Create database (test mode)
   - **Security Rules:** Copy from `SETUP_GUIDE.md`

4. **Done!** Now you can run the app.

## 🎯 What Happens When You Run

Once Flutter is installed and Firebase is set up:

1. `flutter run` will:
   - Build the app
   - Install on connected device/emulator
   - Launch the Study Planner app
   - Show the Login screen

2. You can then:
   - Sign up for an account
   - Create study tasks
   - View calendar
   - Get notifications
   - Manage profile

## 🆘 Troubleshooting

### "Flutter not found"
- Flutter not installed or not in PATH
- Solution: Follow Step 1 above

### "No devices found"
- No emulator running or device connected
- Solution: 
  - Start Android Studio → AVD Manager → Start emulator
  - Or connect phone with USB debugging enabled

### "Firebase error"
- Firebase not configured
- Solution: Follow Firebase setup in Step 3

### "Build failed"
```powershell
flutter clean
flutter pub get
flutter run
```

## 📋 Checklist

Before running, ensure:
- [ ] Flutter SDK installed
- [ ] Flutter in PATH
- [ ] `flutter doctor` works
- [ ] `flutter pub get` completed
- [ ] `google-services.json` in `android\app\`
- [ ] Firebase Authentication enabled
- [ ] Firestore Database created
- [ ] Device/emulator connected

## 🎉 Ready to Go!

Once you complete the 3 steps above, just run:

```powershell
.\start_app.bat
```

Or manually:
```powershell
flutter run
```

The app will start and you'll see the beautiful Study Planner login screen! 🚀

---

**Need detailed help?** See:
- `QUICK_START.md` - Quick reference
- `FIREBASE_SETUP_AUTOMATED.md` - Firebase details
- `SETUP_GUIDE.md` - Complete setup guide


