# Notification System

[![pub package](https://img.shields.io/pub/v/notification_system.svg)](https://pub.dev/packages/notification_system)

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
  - **Compatibility**: Uses namespaced `SharedPreferences` to avoid conflicts with your app's existing dependencies.

## 📦 Installation
 
 ```yaml
 dependencies:
   notification_system: ^0.0.1
 ```

## 🔧 Setup

### 1. Android & iOS Configuration
Follow the official guides for [Firebase Messaging](https://firebase.google.com/docs/flutter/setup) and [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) to set up:
- `google-services.json` / `GoogleService-Info.plist`
- `AndroidManifest.xml` (Permissions, Receivers)
- `Info.plist` (APNS permissions)

### 2. Initialize the Notification System
In your `main.dart`, initialize the system before running the app.

```dart
import 'package:flutter/material.dart';
import 'package:notification_system/notification_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Initialize System
  await NotificationSystem.instance.initialize(
    style: const NotificationStyle(
       successColor: Colors.teal,
    ),
  );

  runApp(const MyApp());
}
```

### 3. Initialize Services (Optional)
The system initializes basic services automatically. You can access them directly:

```dart
final firebaseService = NotificationSystem.instance.firebaseNotificationService;
// Use firebaseService...
```

## 📖 Usage

### Requesting Permissions
User `NotificationSystem.instance.permissionService` to handle the flow.

```dart
import 'package:notification_system/notification_system.dart';

Future<void> checkPermissions(BuildContext context) async {
  final permissionService = NotificationSystem.instance.permissionService;
  
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
Trigger global in-app notifications from anywhere.

```dart
import 'package:notification_system/notification_system.dart';

void confirmOrder() {
  final generalService = NotificationSystem.instance.generalNotificationService;

  // Show Success
  generalService.showSuccess("Order #1234 placed successfully!");
  
  // Show Error
  generalService.showError("Failed to connect to server.");
  
  // Show Warning
  generalService.showWarning("Your session is about to expire.");
}
```

## 🎨 Customization
You can pass a `NotificationStyle` object to `.initialize()` to customize:
- **Colors**: `successColor`, `errorColor`, `warningColor`, `infoColor`.
- **Text Styles**: `titleStyle`, `bodyStyle`.
- **Permission Dialog**: Title, Body, and Button texts.

```dart
await NotificationSystem.instance.initialize(
  style: NotificationStyle(
    successColor: Colors.deepPurple,
    errorColor: Colors.deepOrange,
  ),
);
```
