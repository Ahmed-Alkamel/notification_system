import 'package:flutter/material.dart';

import '../../models/notification_style.dart';
import '../../l10n/app_localizations.dart';

class PermissionDialog extends StatelessWidget {
  final NotificationStyle style;

  const PermissionDialog({super.key, this.style = const NotificationStyle()});

  @override
  Widget build(BuildContext context) {
    final l10n = NotificationLocalizations(Localizations.localeOf(context));

    // Use the passed style
    // final style = widget.style; // StatelessWidget so just style

    return AlertDialog(
      title: Text(
        style.permissionDialogTitle ?? l10n.permissionTitle,
        style: style.titleStyle,
      ),
      content: Text(
        style.permissionDialogBody ?? l10n.permissionBody,
        style: style.bodyStyle,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            style.permissionDialogLaterButtonText ?? l10n.later,
            style: style.bodyStyle?.copyWith(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: style.infoColor, // Use theme primary/info color
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            style.permissionDialogAllowButtonText ?? l10n.allow,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
