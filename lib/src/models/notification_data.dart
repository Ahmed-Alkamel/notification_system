import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_data.freezed.dart';
part 'notification_data.g.dart';

@freezed
abstract class NotificationData with _$NotificationData {
  const factory NotificationData({
    required String title,
    required String body,
    String? payload,
    @Default(NotificationType.info) NotificationType type,
  }) = _NotificationData;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
}

enum NotificationType { info, success, error, warning }
