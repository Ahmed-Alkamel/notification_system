import 'package:flutter/foundation.dart';

abstract class INotificationService {
  Future<void> initialize();
  Future<void> requestPermission();
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  });
}
