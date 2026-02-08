import 'package:flutter/material.dart';

/// Configuration class for customizing the appearance and text of notifications.
///
/// You can provide custom colors for different notification types (success, error, warning, info)
/// and override the text and style of the permission dialog.
class NotificationStyle {
  /// Color for success notifications.
  final Color? successColor;

  /// Color for error notifications.
  final Color? errorColor;

  /// Color for warning notifications.
  final Color? warningColor;

  /// Color for info notifications.
  final Color? infoColor;

  /// Text style for notification titles.
  final TextStyle? titleStyle;

  /// Text style for notification bodies.
  final TextStyle? bodyStyle;

  // Dialog customization
  /// Custom title for the permission request dialog.
  final String? permissionDialogTitle;

  /// Custom body text for the permission request dialog.
  final String? permissionDialogBody;

  /// Custom text for the "Allow" button in the permission dialog.
  final String? permissionDialogAllowButtonText;

  /// Custom text for the "Later" button in the permission dialog.
  final String? permissionDialogLaterButtonText;

  /// Creates a new [NotificationStyle].
  const NotificationStyle({
    this.successColor = Colors.green,
    this.errorColor = Colors.red,
    this.warningColor = Colors.orange,
    this.infoColor = Colors.blue,
    this.titleStyle,
    this.bodyStyle,
    this.permissionDialogTitle,
    this.permissionDialogBody,
    this.permissionDialogAllowButtonText,
    this.permissionDialogLaterButtonText,
  });
}
