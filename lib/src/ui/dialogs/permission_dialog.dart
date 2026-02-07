import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = NotificationLocalizations(Localizations.localeOf(context));

    return AlertDialog(
      title: Text(l10n.permissionTitle),
      content: Text(l10n.permissionBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.later),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.allow),
        ),
      ],
    );
  }
}
