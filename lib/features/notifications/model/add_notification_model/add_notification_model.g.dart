// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNotificationModel _$AddNotificationModelFromJson(
        Map<String, dynamic> json) =>
    AddNotificationModel(
      customerId: (json['customerId'] as num?)?.toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$AddNotificationModelToJson(
        AddNotificationModel instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'title': instance.title,
      'body': instance.body,
    };
