// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRoleModel _$UserRoleModelFromJson(Map<String, dynamic> json) =>
    UserRoleModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$UserRoleModelToJson(UserRoleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
