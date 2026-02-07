import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:injectable/injectable.dart';
import '../ui/dialogs/permission_dialog.dart';

@singleton
class PermissionService {
  static const String _kNotificationPermissionAsked =
      'notification_permission_asked';
  final SharedPreferences _prefs;

  PermissionService(this._prefs);

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
        builder: (context) => const PermissionDialog(),
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
