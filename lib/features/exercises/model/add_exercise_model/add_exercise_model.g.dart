// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddExerciseModel _$AddExerciseModelFromJson(Map<String, dynamic> json) =>
    AddExerciseModel(
      name: json['name'] as String?,
      link: json['link'] as String?,
      file: json['link_file'] as String?,
      description: json['description'] == null
          ? null
          : AddExerciseDescriptionModel.fromJson(
              json['description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddExerciseModelToJson(AddExerciseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'link': instance.link,
      'link_file': Utils.nullableFileToJson(instance.file),
      'description': instance.description.toJson(),
    };
