import 'package:flutter/material.dart';

class NotificationStyle {
  final Color successColor;
  final Color errorColor;
  final Color warningColor;
  final Color infoColor;
  final TextStyle? titleStyle;
  final TextStyle? bodyStyle;

  // Dialog customization
  final String? permissionDialogTitle;
  final String? permissionDialogBody;
  final String? permissionDialogAllowButtonText;
  final String? permissionDialogLaterButtonText;

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
