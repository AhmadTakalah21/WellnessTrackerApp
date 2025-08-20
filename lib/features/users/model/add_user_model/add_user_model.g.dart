// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUserModel _$AddUserModelFromJson(Map<String, dynamic> json) => AddUserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      role: DepartmentEnum.fromJson2(json['role'] as String),
    );

Map<String, dynamic> _$AddUserModelToJson(AddUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'role': DepartmentEnum.toJson2(instance.role),
    };
