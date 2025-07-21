// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNotificationModel _$AddNotificationModelFromJson(
        Map<String, dynamic> json) =>
    AddNotificationModel(
      isAll: json['isAll'] as String? ?? "false",
      title: json['title'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AddNotificationModelToJson(
        AddNotificationModel instance) =>
    <String, dynamic>{
      'isAll': instance.isAll,
      'title': instance.title,
      'message': instance.message,
    };
