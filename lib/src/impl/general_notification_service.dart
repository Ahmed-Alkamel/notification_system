import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../models/notification_style.dart';

class GeneralNotificationService {
  final NotificationStyle _style;

  GeneralNotificationService(this._style);

  void showSuccess(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message, style: _style.bodyStyle),
      background: _style.successColor,
      duration: duration,
    );
  }

  void showError(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message, style: _style.bodyStyle),
      background: _style.errorColor,
      duration: duration,
    );
  }

  void showInfo(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message, style: _style.bodyStyle),
      background: _style.infoColor,
      duration: duration,
    );
  }

  void showWarning(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message, style: _style.bodyStyle),
      background: _style.warningColor,
      duration: duration,
    );
  }
}
