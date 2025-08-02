// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) =>
    ExerciseModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: ExerciseDescriptionModel.fromJson(
          json['description'] as Map<String, dynamic>),
      link: json['link'] as String,
      coach: CustomerModel.fromJson(json['coach'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$ExerciseModelToJson(ExerciseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'link': instance.link,
      'coach': instance.coach,
      'created_at': instance.createdAt,
    };
