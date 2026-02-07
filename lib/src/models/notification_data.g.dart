// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    _NotificationData(
      title: json['title'] as String,
      body: json['body'] as String,
      payload: json['payload'] as String?,
      type:
          $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']) ??
          NotificationType.info,
    );

Map<String, dynamic> _$NotificationDataToJson(_NotificationData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'payload': instance.payload,
      'type': _$NotificationTypeEnumMap[instance.type]!,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.info: 'info',
  NotificationType.success: 'success',
  NotificationType.error: 'error',
  NotificationType.warning: 'warning',
};
