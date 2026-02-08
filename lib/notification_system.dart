library;

// API
export 'src/api/notification_service.dart';

// Models
export 'src/models/notification_data.dart';
export 'src/models/notification_style.dart';

// Services (Export classes so users can extend/use them)
export 'src/impl/firebase_notification_service.dart';
export 'src/impl/local_notification_service.dart';
export 'src/impl/general_notification_service.dart';
export 'src/services/permission_service.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'src/impl/firebase_notification_service.dart';
import 'src/impl/general_notification_service.dart';
import 'src/impl/local_notification_service.dart';
import 'src/models/notification_style.dart';
import 'src/services/permission_service.dart';

class NotificationSystem {
  NotificationSystem._();
  static final NotificationSystem instance = NotificationSystem._();

  // Services
  late final PermissionService permissionService;
  late final LocalNotificationService localNotificationService;
  late final FirebaseNotificationService firebaseNotificationService;
  late final GeneralNotificationService generalNotificationService;

  bool _isInitialized = false;

  /// Initialize the notification system.
  ///
  /// You can pass custom implementations of services here if needed.
  /// If not provided, default implementations will be used.
  ///
  /// [style] Customize the look and feel of notifications and dialogs.
  Future<void> initialize({
    NotificationStyle style = const NotificationStyle(),
    PermissionService? permissionService,
    LocalNotificationService? localNotificationService,
    FirebaseNotificationService? firebaseNotificationService,
    GeneralNotificationService? generalNotificationService,
  }) async {
    if (_isInitialized) return;

    // 1. Initialize dependencies
    final prefs = await SharedPreferences.getInstance();

    // 2. Initialize Services (Use injected or create default)
    this.permissionService =
        permissionService ?? PermissionService(prefs, style: style);

    this.localNotificationService =
        localNotificationService ?? LocalNotificationService();
    await this.localNotificationService.initialize();

    this.firebaseNotificationService =
        firebaseNotificationService ??
        FirebaseNotificationService(this.localNotificationService);
    await this.firebaseNotificationService.initialize();

    this.generalNotificationService =
        generalNotificationService ?? GeneralNotificationService(style);

    _isInitialized = true;
  }
  static Future<String?> get fcmToken =>  instance.firebaseNotificationService.getToken();

}
