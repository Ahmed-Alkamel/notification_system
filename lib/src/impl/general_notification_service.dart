import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../models/notification_style.dart';

/// Service for displaying in-app notifications (toasts/overlays).
///
/// Uses `overlay_support` to show messages at the top of the screen.
/// The appearance is customized via [NotificationStyle].
class GeneralNotificationService {
  final NotificationStyle _style;

  /// Creates a [GeneralNotificationService] with the given style.
  GeneralNotificationService(this._style);

  /// Shows a success notification (typically green).
  void showSuccess(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message, style: _style.bodyStyle),
      background: _style.successColor,
      duration: duration,
    );
  }

  /// Shows an error notification (typically red).
  void showError(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message, style: _style.bodyStyle),
      background: _style.errorColor,
      duration: duration,
    );
  }

  /// Shows an info notification (typically blue/neutral).
  void showInfo(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message, style: _style.bodyStyle),
      background: _style.infoColor,
      duration: duration,
    );
  }

  /// Shows a warning notification (typically orange/yellow).
  void showWarning(String message, {Duration? duration}) {
    showSimpleNotification(
      Text(message, style: _style.bodyStyle),
      background: _style.warningColor,
      duration: duration,
    );
  }
}
