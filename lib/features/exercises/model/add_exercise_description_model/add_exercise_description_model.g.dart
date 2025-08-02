// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_exercise_description_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddExerciseDescriptionModel _$AddExerciseDescriptionModelFromJson(
        Map<String, dynamic> json) =>
    AddExerciseDescriptionModel(
      rounds: (json['rounds'] as num?)?.toInt(),
      explain: json['explain'] as String?,
      repeats: (json['repeats'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$AddExerciseDescriptionModelToJson(
        AddExerciseDescriptionModel instance) =>
    <String, dynamic>{
      'rounds': instance.rounds,
      'explain': instance.explain,
      'repeats': instance.repeats,
    };
