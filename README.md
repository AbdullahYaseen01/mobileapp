# 📚 Study Planner App

A comprehensive Flutter mobile application for managing study tasks with Firebase backend.

![Study Planner](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Firebase](https://img.shields.io/badge/Firebase-Enabled-orange.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## 🎯 Features

### ✅ Authentication
- Email/Password sign up and login
- Password reset functionality
- Secure authentication with Firebase

### ✅ Task Management
- Create, edit, and delete study tasks
- Subject-based organization (Math, Science, English, etc.)
- Date and time scheduling
- Task notes and descriptions
- Mark tasks as completed/pending
- Color-coded tasks by subject

### ✅ Calendar View
- Monthly and weekly calendar views
- Visual indicators for dates with tasks
- Daily task list
- Easy date selection and navigation

### ✅ Notifications
- Task reminders (15 minutes before)
- Local notifications
- Firebase Cloud Messaging integration

### ✅ User Profile
- View and edit profile information
- Change password
- View statistics (total tasks, completion rate)
- Logout functionality

### ✅ Beautiful UI/UX
- Material Design 3
- Light and Dark theme support
- Smooth animations
- Responsive design
- Loading states and error handling

## 📱 Screenshots

### Login Screen
- Clean and modern authentication interface
- Form validation
- Error handling

### Home Dashboard
- Welcome message with user name
- Today's tasks section
- Statistics cards (Total, Completed, Pending)
- Quick access to add tasks

### Calendar View
- Interactive calendar with task indicators
- Date selection
- Daily task list

### Task Management
- Add/Edit task forms
- Subject selection
- Date and time pickers
- Notes field

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── task_model.dart
│   └── user_model.dart
├── screens/                  # UI screens
│   ├── auth/                 # Authentication screens
│   ├── home/                 # Home/Dashboard
│   ├── tasks/                # Task management
│   ├── calendar/             # Calendar view
│   └── profile/              # User profile
├── widgets/                   # Reusable widgets
├── services/                 # Business logic
│   ├── auth_service.dart
│   ├── firestore_service.dart
│   └── notification_service.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   └── task_provider.dart
└── utils/                    # Utilities
    ├── app_theme.dart
    └── constants.dart
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Firebase account
- Android Studio / Xcode (for mobile development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd study_planner
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android app (package: `com.example.study_planner`)
   - Download `google-services.json` → place in `android/app/`
   - Add iOS app (if needed) → download `GoogleService-Info.plist` → place in `ios/Runner/`
   - Enable Authentication (Email/Password)
   - Enable Firestore Database
   - Add security rules (see `SETUP_GUIDE.md`)

4. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

- `firebase_core` - Firebase initialization
- `firebase_auth` - User authentication
- `cloud_firestore` - NoSQL database
- `firebase_messaging` - Push notifications
- `provider` - State management
- `table_calendar` - Calendar widget
- `flutter_local_notifications` - Local notifications
- `intl` - Date formatting
- `timezone` - Timezone support

## 🔧 Configuration

### Firebase Setup
See `SETUP_GUIDE.md` for detailed Firebase configuration instructions.

### Security Rules
Firestore security rules are provided in `SETUP_GUIDE.md`. Make sure to add them in Firebase Console.

## 📖 Documentation

- `SETUP_GUIDE.md` - Complete setup instructions
- `FIREBASE_SETUP_AUTOMATED.md` - Firebase setup guide
- `PROJECT_COMPLETE.md` - Feature list and project status
- `START_HERE.md` - Quick start guide
- `QUICK_START.md` - Quick reference

## 🎨 UI/UX Features

- **Material Design 3** - Modern, beautiful interface
- **Theme Support** - Light and dark themes
- **Responsive Design** - Works on all screen sizes
- **Smooth Animations** - Polished user experience
- **Error Handling** - User-friendly error messages
- **Loading States** - Clear feedback during operations
- **Empty States** - Helpful messages when no data

## 🔐 Security

- Firebase Authentication for secure user management
- Firestore security rules for data protection
- User-scoped data access
- Secure password handling

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web (can be enabled)

## 🛠️ Development

### Code Structure
- Clean architecture with separation of concerns
- Provider pattern for state management
- Reusable widgets and components
- Proper error handling throughout

### Best Practices
- Null safety
- Async/await for asynchronous operations
- Try-catch error handling
- Form validation
- Loading states

## 📝 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## 👨‍💻 Author

Study Planner App - Built with Flutter and Firebase

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All open-source package contributors

---

**Made with ❤️ using Flutter**
