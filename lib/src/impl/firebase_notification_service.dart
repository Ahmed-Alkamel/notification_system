import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import '../impl/local_notification_service.dart';

@singleton
class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final LocalNotificationService _localNotificationService;

  FirebaseNotificationService(this._localNotificationService);

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
