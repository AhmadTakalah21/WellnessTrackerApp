// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSignUpModel _$PostSignUpModelFromJson(Map<String, dynamic> json) =>
    PostSignUpModel(
      username: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['password_confirmation'] as String?,
      fcmToken: json['fcm_token'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$PostSignUpModelToJson(PostSignUpModel instance) =>
    <String, dynamic>{
      'fcm_token': instance.fcmToken,
      'password_confirmation': instance.confirmPassword,
      'name': instance.username,
      'email': instance.email,
      'phone': instance.phoneNumber,
      'password': instance.password,
      'code': instance.code,
    };
