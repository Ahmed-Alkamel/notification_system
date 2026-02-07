# Notification System

A comprehensive, production-ready notification handling package for Flutter. It seamlessly integrates Firebase Cloud Messaging (FCM), Local Notifications, and In-App messaging into a unified API. Built with clean architecture principles, it offers robust permission handling with caching and localization support.

## 🚀 Features

- **🔥 Firebase Messaging Integration**: 
  - Handles background, terminated, and foreground messages automatically.
  - Exposes FCM token generation.
  - Automatically bridges FCM notifications to Local Notifications when in foreground.

- **🔔 Local Notifications**:
  - Show system tray notifications on Android and iOS.
  - Configurable channels and importance levels.

- **💬 In-App Notifications**:
  - Show beautiful, non-intrusive toasts/snackbars for app events.
  - **Types**: Success (Green), Error (Red), Warning (Orange), Info (Blue).
  - Fully customizable via `overlay_support`.

- **🛡️ Smart Permission Handling**:
  - **Custom Pre-Request Dialog**: Shows a friendly dialog explaining *why* permissions are needed before triggering the native OS prompt.
  - **Preference Caching**: Remembers if the user clicked "Later" to avoid spamming them on every launch.
  - **Context-Aware**: Only requests native permissions when the user explicitly agrees.

- **🌍 Localization**:
  - Built-in support for **English (en)** and **Arabic (ar)**.
  - Automatically detects system locale for the permission dialog.

- **🏗️ Solid Architecture**:
  - **Dependency Injection**: Powered by `injectable` and `get_it`.
  - **Immutability**: Data models generated using `freezed`.
  - **Type Safety**: Strictly typed interfaces for all services.

## 📦 Installation

This package relies on several dependencies. Ensure your `pubspec.yaml` is up to date.

```yaml
dependencies:
  notification_system: path/to/this/package
```

## 🔧 Setup

### 1. Android & iOS Configuration
Follow the official guides for [Firebase Messaging](https://firebase.google.com/docs/flutter/setup) and [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) to set up:
- `google-services.json` / `GoogleService-Info.plist`
- `AndroidManifest.xml` (Permissions, Receivers)
- `Info.plist` (APNS permissions)

### 2. Initialize the Notification System
In your `main.dart`, initialize the dependency injection before running the app.

```dart
import 'package:flutter/material.dart';
import 'package:notification_system/notification_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Initialize DI
  await configureDependencies();

  runApp(const MyApp());
}
```

### 3. Initialize Services
At the start of your app (e.g., in a `SplashScreen` or `HomeWrapper`), initialize the Firebase service.

```dart
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    final firebaseService = getIt<FirebaseNotificationService>();
    await firebaseService.initialize();
    
    // Optional: Print Token
    final token = await firebaseService.getToken();
    print("FCM Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
```

## 📖 Usage

### Requesting Permissions
Use `PermissionService` to handle the flow. This will check cache, show the custom dialog if needed, and then request native permissions.

```dart
import 'package:notification_system/notification_system.dart';

Future<void> checkPermissions(BuildContext context) async {
  final permissionService = getIt<PermissionService>();
  
  // Returns true if granted (either previously or just now)
  bool granted = await permissionService.requestNotificationPermission(context);
  
  if (granted) {
    print("User has enabled notifications!");
  } else {
    print("User denied or postponed notifications.");
  }
}
```

### Showing In-App Messages
Trigger global in-app notifications from anywhere in your code using `GeneralNotificationService`.

```dart
import 'package:notification_system/notification_system.dart';

void confirmOrder() {
  final generalService = getIt<GeneralNotificationService>();

  // Show Success
  generalService.showSuccess("Order #1234 placed successfully!");
  
  // Show Error
  generalService.showError("Failed to connect to server.");
  
  // Show Warning
  generalService.showWarning("Your session is about to expire.");
}
```

## 🧩 Modifying the Package

If you change any `@injectable` or `@freezed` annotated classes, run the build runner to regenerate code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
