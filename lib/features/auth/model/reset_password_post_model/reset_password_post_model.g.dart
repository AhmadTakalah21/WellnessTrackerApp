// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordPostModel _$ResetPasswordPostModelFromJson(
  Map<String, dynamic> json,
) => ResetPasswordPostModel(
  password: json['password'] as String?,
  confirmPassword: json['confirmPassword'] as String?,
);

Map<String, dynamic> _$ResetPasswordPostModelToJson(
  ResetPasswordPostModel instance,
) => <String, dynamic>{
  'confirmPassword': instance.confirmPassword,
  'password': instance.password,
};
