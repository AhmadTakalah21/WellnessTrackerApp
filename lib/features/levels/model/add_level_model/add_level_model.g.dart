// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLevelModel _$AddLevelModelFromJson(Map<String, dynamic> json) =>
    AddLevelModel(
      name: json['name'] as String?,
      type: DepartmentEnum.fromJson((json['type'] as num).toInt()),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AddLevelModelToJson(AddLevelModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': DepartmentEnum.toJson(instance.type),
      'description': instance.description,
    };
