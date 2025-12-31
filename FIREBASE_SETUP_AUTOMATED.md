# Automated Firebase Setup Guide

## ⚠️ Important Note

I cannot directly create Firebase projects or download configuration files as they require:
- Google account authentication
- Firebase Console access
- Project-specific credentials

However, I've created all the necessary project structure. Here's what you need to do:

## Quick Setup Steps

### 1. Install Flutter (if not installed)
```bash
# Check if Flutter is installed
flutter --version

# If not installed, download from: https://flutter.dev/docs/get-started/install
# Add Flutter to your PATH
```

### 2. Initialize Flutter Project
```bash
# Navigate to project directory
cd d:\mobileapp

# Create Flutter project structure (if needed)
flutter create .

# Install dependencies
flutter pub get
```

### 3. Firebase Console Setup

**You need to do this manually:**

1. Go to https://console.firebase.google.com/
2. Click "Add project" or select existing
3. Project name: **Study Planner**
4. Follow setup wizard

#### For Android:
1. Click Android icon → Add app
2. Package name: `com.example.study_planner` (or check `android/app/build.gradle` for actual package)
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`

#### For iOS:
1. Click iOS icon → Add app
2. Bundle ID: Check `ios/Runner.xcodeproj` or use `com.example.studyPlanner`
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`
5. Open Xcode and add file to project

### 4. Enable Firebase Services

In Firebase Console:

1. **Authentication:**
   - Go to Authentication → Sign-in method
   - Enable "Email/Password"

2. **Firestore Database:**
   - Go to Firestore Database
   - Create database → Start in test mode
   - Choose location
   - Add security rules (see below)

3. **Cloud Messaging:**
   - Already enabled by default

### 5. Firestore Security Rules

Go to Firestore Database → Rules tab, paste:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /tasks/{taskId} {
      allow read, update, delete: if request.auth != null && 
        request.auth.uid == resource.data.userId;
      allow create: if request.auth != null && 
        request.auth.uid == request.resource.data.userId;
    }
  }
}
```

### 6. Run the App

```bash
# Check connected devices
flutter devices

# Run on connected device/emulator
flutter run

# Or build APK
flutter build apk
```

## Verification Checklist

- [ ] Flutter installed and in PATH
- [ ] `flutter pub get` completed successfully
- [ ] `google-services.json` in `android/app/`
- [ ] `GoogleService-Info.plist` in `ios/Runner/`
- [ ] Authentication enabled in Firebase
- [ ] Firestore Database created
- [ ] Security rules added
- [ ] App runs without Firebase errors

## Troubleshooting

### Flutter not found
- Install Flutter SDK
- Add to PATH
- Restart terminal

### Firebase initialization error
- Check config files are in correct locations
- Verify package name/bundle ID matches Firebase
- Check Firebase services are enabled

### Build errors
- Run `flutter clean`
- Run `flutter pub get`
- For Android: Check `android/app/build.gradle` has google-services plugin
- For iOS: Run `cd ios && pod install`


