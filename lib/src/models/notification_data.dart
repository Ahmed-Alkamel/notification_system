import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_data.freezed.dart';
part 'notification_data.g.dart';

/// Data model representing a notification payload.
@freezed
abstract class NotificationData with _$NotificationData {
  /// Creates a [NotificationData] instance.
  ///
  /// [title] The notification title.
  /// [body] The notification body text.
  /// [payload] Optional data payload.
  /// [type] The type of notification (info, success, error, warning).
  const factory NotificationData({
    required String title,
    required String body,
    String? payload,
    @Default(NotificationType.info) NotificationType type,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}

/// Enum describing the type of notification.
/// Used primarily for styling in-app notifications.
enum NotificationType {
  /// Neutral information.
  info,

  /// Success message (e.g. Operation completed).
  success,

  /// Error message (e.g. Network failed).
  error,

  /// Warning message (e.g. Session expiring).
  warning,
}
