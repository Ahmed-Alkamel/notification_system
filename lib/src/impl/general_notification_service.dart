import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:injectable/injectable.dart';

@singleton
class GeneralNotificationService {
  void showSuccess(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message),
      background: Colors.green,
      duration: duration,
    );
  }

  void showError(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message),
      background: Colors.red,
      duration: duration,
    );
  }

  void showInfo(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message),
      background: Colors.blue,
      duration: duration,
    );
  }

  void showWarning(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message),
      background: Colors.orange,
      duration: duration,
    );
  }
}
