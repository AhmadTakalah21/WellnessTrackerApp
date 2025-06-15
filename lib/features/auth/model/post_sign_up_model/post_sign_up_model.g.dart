// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSignUpModel _$PostSignUpModelFromJson(Map<String, dynamic> json) =>
    PostSignUpModel(
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$PostSignUpModelToJson(PostSignUpModel instance) =>
    <String, dynamic>{
      'confirmPassword': instance.confirmPassword,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };
