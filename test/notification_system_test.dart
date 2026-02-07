import 'package:flutter_test/flutter_test.dart';

import 'package:notification_system/notification_system.dart';

void main() {
  test('verify exports', () {
    // Just verify that the library imports without error
    // ignore: unnecessary_type_check
    expect(NotificationSystem.instance, isNotNull);
  });
}
