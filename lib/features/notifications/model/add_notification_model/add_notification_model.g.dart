// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNotificationModel _$AddNotificationModelFromJson(
        Map<String, dynamic> json) =>
    AddNotificationModel(
      isAll: json['is_all'] as String? ?? "0",
      title: json['title'] as String?,
      message: json['message'] as String?,
      time: json['time'] as String?,
      tz: json['tz'] as String?,
    );

Map<String, dynamic> _$AddNotificationModelToJson(
        AddNotificationModel instance) =>
    <String, dynamic>{
      'is_all': instance.isAll,
      'title': instance.title,
      'message': instance.message,
      'time': instance.time,
      'tz': instance.tz,
    };
