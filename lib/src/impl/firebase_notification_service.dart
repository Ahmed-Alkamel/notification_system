import 'package:firebase_messaging/firebase_messaging.dart';

import '../api/notification_service.dart';
import '../impl/local_notification_service.dart';

/// Service for handling Firebase Cloud Messaging (FCM).
///
/// This service manages:
/// - Requesting FCM permissions (handled via [requestPermission]).
/// - retrieving the FCM token ([getToken]).
/// - Handling foreground messages and bridging them to [LocalNotificationService].
/// - Handling background messages.
class FirebaseNotificationService implements INotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final LocalNotificationService _localNotificationService;

  /// Creates a [FirebaseNotificationService] dependent on [LocalNotificationService] for foreground display.
  FirebaseNotificationService(this._localNotificationService);

  @override
  Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // print('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    // FCM doesn't support manually showing a notification from the client side in the same way.
    // This method might be used if we want to simulate an FCM message?
    // For now, let's delegate to local notification service as a fallback or bridge.
    await _localNotificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      payload: payload,
    );
  }

  Future<void> initialize() async {
    // Force initialization of local notifications if not already done,
    // although it should be initialized by the main app or DI.
    await _localNotificationService.initialize();

    // Handler for background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handler for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _localNotificationService.showNotification(
          id: message.hashCode,
          title: message.notification!.title ?? '',
          body: message.notification!.body ?? '',
          payload: message.data.toString(),
        );
      }
    });

    await _firebaseMessaging.requestPermission();
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}

// Must be a top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you need to access other services here, make sure they are initialized
  // or use a separate entry point logic if complex.
  // print("Handling a background message: ${message.messageId}");
}
