// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInModel _$SignInModelFromJson(Map<String, dynamic> json) => SignInModel(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      token: json['token'] as String?,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      isV1: json['v1'] as bool? ?? false,
      role: UserRoleEnum.fromJson(json['role'] as String),
    );

Map<String, dynamic> _$SignInModelToJson(SignInModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'token': instance.token,
      'name': instance.name,
      'phone': instance.phone,
      'v1': instance.isV1,
      'role': UserRoleEnum.toJson(instance.role),
    };
