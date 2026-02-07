import 'dart:ui';

class NotificationLocalizations {
  final Locale locale;

  NotificationLocalizations(this.locale);

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'permission_title': 'Enable Notifications',
      'permission_body':
          'Please enable notifications to receive updates about your orders and status.',
      'allow': 'Allow',
      'later': 'Later',
    },
    'ar': {
      'permission_title': 'تفعيل الإشعارات',
      'permission_body':
          'يرجى تفعيل الإشعارات لتلقي تحديثات حول طلباتك وحالتها.',
      'allow': 'سماح',
      'later': 'لاحقاً',
    },
  };

  String get permissionTitle {
    return _localizedValues[locale.languageCode]?['permission_title'] ??
        _localizedValues['en']!['permission_title']!;
  }

  String get permissionBody {
    return _localizedValues[locale.languageCode]?['permission_body'] ??
        _localizedValues['en']!['permission_body']!;
  }

  String get allow {
    return _localizedValues[locale.languageCode]?['allow'] ??
        _localizedValues['en']!['allow']!;
  }

  String get later {
    return _localizedValues[locale.languageCode]?['later'] ??
        _localizedValues['en']!['later']!;
  }
}
