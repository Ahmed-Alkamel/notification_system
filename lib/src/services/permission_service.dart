import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/notification_style.dart';
import '../ui/dialogs/permission_dialog.dart';

/// Service responsible for handling notification permissions.
///
/// This service checks for existing permissions, shows a rationale dialog if needed (configured via [NotificationStyle]),
/// and requests native permissions from the OS.
/// It uses [SharedPreferences] to cache whether the user has already been asked, to avoid spamming.
class PermissionService {
  static const String _kNotificationPermissionAsked =
      'notification_permission_asked';
  final SharedPreferences _prefs;
  final NotificationStyle _style;

  /// Creates a [PermissionService] with the given preferences and style.
  PermissionService(this._prefs, {NotificationStyle? style})
    : _style = style ?? const NotificationStyle();

  /// Requests notification permissions from the user.
  ///
  /// Returns `true` if permission is granted, `false` otherwise.
  ///
  /// Flow:
  /// 1. Check current status. If granted, return true.
  /// 2. If permanently denied, return false (user must go to settings).
  /// 3. Check if we already asked the user (cached in prefs).
  /// 4. If not asked:
  ///    - Show rationale dialog (if configured).
  ///    - If user agrees in dialog, request native permission.
  ///    - If user cancels, mark as asked and return false.
  /// 5. If already asked:
  ///    - Request native permission directly (OS might not show prompt if denied previously).
  Future<bool> requestNotificationPermission(BuildContext context) async {
    final status = await Permission.notification.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      // Open settings? Or show dialog explaining
      return false;
    }

    final alreadyAsked = _prefs.getBool(_kNotificationPermissionAsked) ?? false;

    if (!alreadyAsked) {
      if (!context.mounted) return false;
      // Show custom dialog
      final shouldAsk = await showDialog<bool>(
        context: context,
        builder: (context) => PermissionDialog(style: _style),
      );

      if (shouldAsk == true) {
        await _prefs.setBool(_kNotificationPermissionAsked, true);
        if (!context.mounted) return false;
        final result = await Permission.notification.request();
        return result.isGranted;
      } else {
        await _prefs.setBool(
          _kNotificationPermissionAsked,
          true,
        ); // Mark as asked even if denied/deferred
        return false;
      }
    } else {
      // If already asked and denied, we might not want to bug them again immediately,
      // or we could check if we should show a rationale.
      // For now, let's just request it directly if it's not permanently denied.
      final result = await Permission.notification.request();
      return result.isGranted;
    }
  }
}
