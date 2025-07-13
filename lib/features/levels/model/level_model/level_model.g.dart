// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelModel _$LevelModelFromJson(Map<String, dynamic> json) => LevelModel(
      id: (json['id'] as num).toInt(),
      image: json['image'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: DepartmentEnum.fromJson((json['type'] as num).toInt()),
      time: json['time'] as String,
    );

Map<String, dynamic> _$LevelModelToJson(LevelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'description': instance.description,
      'type': DepartmentEnum.toJson(instance.type),
      'time': instance.time,
    };
