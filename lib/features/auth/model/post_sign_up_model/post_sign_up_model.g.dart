// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSignUpModel _$PostSignUpModelFromJson(Map<String, dynamic> json) =>
    PostSignUpModel(
      username: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['password_confirmation'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$PostSignUpModelToJson(PostSignUpModel instance) =>
    <String, dynamic>{
      'password_confirmation': instance.confirmPassword,
      'name': instance.username,
      'email': instance.email,
      'password': instance.password,
      'code': instance.code,
    };
