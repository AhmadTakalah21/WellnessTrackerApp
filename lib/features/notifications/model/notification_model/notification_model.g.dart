// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      data: json['data'],
      senderId: (json['sender_id'] as num?)?.toInt(),
      receiverId: (json['receiver_id'] as num?)?.toInt(),
      sendAt: json['send_at'] as String?,
      isSent: const BoolConverter().fromJson(json['is_sent']),
      image: JsonUtils.setImageUrlNullableFromJson(
          JsonUtils.readValue(json, 'image') as Map<String, dynamic>),
      received: const BoolConverter().fromJson(json['received']),
      createdAt: DateTime.parse(json['created_at'] as String),
      message: json['message'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'data': instance.data,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'send_at': instance.sendAt,
      'is_sent': const BoolConverter().toJson(instance.isSent),
      'image': instance.image,
      'received': const BoolConverter().toJson(instance.received),
      'created_at': instance.createdAt.toIso8601String(),
      'message': instance.message,
    };
