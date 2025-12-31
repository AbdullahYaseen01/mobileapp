# Phase 1 Setup Guide - Study Planner App

## Step 1: Initialize Flutter Project

If you haven't already created the Flutter project, run:

```bash
flutter create study_planner
cd study_planner
```

Then replace the generated files with the structure provided in this project.

## Step 2: Install Dependencies

Run the following command to install all Flutter packages:

```bash
flutter pub get
```

## Step 3: Firebase Project Setup

### 3.1 Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: **Study Planner**
4. Enable/disable Google Analytics (optional)
5. Click "Create project"

### 3.2 Add Android App to Firebase

1. In Firebase Console, click the Android icon (or "Add app")
2. Enter Android package name:
   - Check your `android/app/build.gradle` file for `applicationId`
   - Default: `com.example.study_planner`
   - **Important**: Use the exact package name from your app
3. Enter app nickname: **Study Planner** (optional)
4. Enter Debug signing certificate SHA-1 (optional for development):
   ```bash
   # On Windows (PowerShell)
   cd android
   .\gradlew signingReport
   ```
   Copy the SHA-1 from the output
5. Click "Register app"
6. Download `google-services.json`
7. Place the file in: `android/app/google-services.json`

### 3.3 Configure Android Build Files

**File: `android/build.gradle` (Project level)**

Add to the `dependencies` block:
```gradle
dependencies {
    // ... existing code ...
    classpath 'com.google.gms:google-services:4.4.0'
}
```

**File: `android/app/build.gradle`**

1. Add at the top (after other plugins):
```gradle
apply plugin: 'com.google.gms.google-services'
```

2. Ensure minimum SDK is 21 or higher:
```gradle
android {
    defaultConfig {
        minSdkVersion 21
        // ... other config
    }
}
```

### 3.4 Add iOS App to Firebase (if developing for iOS)

1. In Firebase Console, click the iOS icon
2. Enter iOS bundle ID:
   - Check `ios/Runner.xcodeproj` or `ios/Runner/Info.plist`
   - Default: `com.example.studyPlanner`
3. Enter app nickname: **Study Planner**
4. Click "Register app"
5. Download `GoogleService-Info.plist`
6. Open `ios/Runner.xcodeproj` in Xcode
7. Right-click `Runner` folder → "Add Files to Runner"
8. Select `GoogleService-Info.plist`
9. Ensure "Copy items if needed" is checked
10. Click "Add"

**File: `ios/Podfile`**

Ensure minimum iOS version:
```ruby
platform :ios, '12.0'
```

Then run:
```bash
cd ios
pod install
cd ..
```

### 3.5 Enable Firebase Services

#### Authentication

1. Go to Firebase Console → **Authentication**
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable **Email/Password**
5. Click "Save"

#### Firestore Database

1. Go to Firebase Console → **Firestore Database**
2. Click "Create database"
3. Select **Start in test mode** (we'll add security rules)
4. Choose a location (select closest to your users)
5. Click "Enable"

#### Firestore Security Rules

1. Go to Firestore Database → **Rules** tab
2. Replace the rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection - users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Tasks collection - users can only access their own tasks
    match /tasks/{taskId} {
      // Read and update: only if user owns the task
      allow read, update, delete: if request.auth != null && 
        request.auth.uid == resource.data.userId;
      
      // Create: only if user sets their own userId
      allow create: if request.auth != null && 
        request.auth.uid == request.resource.data.userId;
    }
  }
}
```

3. Click "Publish"

#### Cloud Messaging (Optional for now)

Cloud Messaging is enabled by default. We'll configure it in Phase 8.

## Step 4: Verify Setup

### 4.1 Check Dependencies

```bash
flutter pub get
```

### 4.2 Verify Firebase Configuration

**Android:**
- Check that `android/app/google-services.json` exists
- Verify `android/app/build.gradle` has the plugin applied

**iOS:**
- Check that `ios/Runner/GoogleService-Info.plist` exists
- Verify pods are installed: `cd ios && pod install`

### 4.3 Test Run

```bash
flutter run
```

The app should:
- Start without errors
- Show the Login Screen (since no user is authenticated)
- Not crash on Firebase initialization

## Step 5: Project Structure Verification

Your project should have this structure:

```
study_planner/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── task_model.dart
│   │   └── user_model.dart
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── auth_wrapper.dart
│   │   │   ├── login_screen.dart
│   │   │   ├── signup_screen.dart
│   │   │   └── forgot_password_screen.dart
│   │   ├── home/
│   │   │   └── home_screen.dart
│   │   ├── tasks/
│   │   │   ├── add_task_screen.dart
│   │   │   ├── edit_task_screen.dart
│   │   │   └── task_details_screen.dart
│   │   ├── calendar/
│   │   │   └── calendar_screen.dart
│   │   └── profile/
│   │       └── profile_screen.dart
│   ├── widgets/
│   │   └── task_card.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── firestore_service.dart
│   │   └── notification_service.dart
│   ├── providers/
│   │   └── auth_provider.dart
│   └── utils/
│       ├── app_theme.dart
│       └── constants.dart
├── android/
│   └── app/
│       └── google-services.json (you need to add this)
├── ios/
│   └── Runner/
│       └── GoogleService-Info.plist (you need to add this)
├── pubspec.yaml
├── README.md
└── analysis_options.yaml
```

## Troubleshooting

### Error: "FirebaseApp not initialized"

- Ensure `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location
- Verify Firebase is initialized in `main.dart` before `runApp()`
- Check that `firebase_core` is in `pubspec.yaml`

### Error: "MissingPluginException"

- Run `flutter clean`
- Run `flutter pub get`
- For Android: Rebuild the app
- For iOS: Run `cd ios && pod install && cd ..`

### Error: "Package not found"

- Run `flutter pub get`
- Check `pubspec.yaml` for typos
- Ensure you're using compatible package versions

### Android Build Error

- Ensure `minSdkVersion` is 21 or higher
- Check that `google-services.json` is in `android/app/`
- Verify the plugin is applied in `android/app/build.gradle`

### iOS Build Error

- Run `cd ios && pod install`
- Ensure `GoogleService-Info.plist` is added to Xcode project
- Check that iOS deployment target is 12.0 or higher

## Next Steps

Once Phase 1 is complete and verified:

1. ✅ Project structure created
2. ✅ Dependencies added
3. ✅ Firebase initialized
4. ✅ Basic models and services created
5. ⏭️ **Ready for Phase 2: Authentication System**

Proceed to Phase 2 when you're ready!


