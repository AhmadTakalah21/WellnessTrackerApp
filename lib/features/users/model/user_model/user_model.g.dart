// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: UserRoleEnum.fromJson(json['role'] as String),
      status: json['status'] as String,
      subscribersCount: (json['sum'] as num?)?.toInt() ?? 0,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'role': UserRoleEnum.toJson(instance.role),
      'status': instance.status,
      'sum': instance.subscribersCount,
      'fcm_token': instance.fcmToken,
    };
