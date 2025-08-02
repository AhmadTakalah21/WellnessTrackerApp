// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_description_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseDescriptionModel _$ExerciseDescriptionModelFromJson(
        Map<String, dynamic> json) =>
    ExerciseDescriptionModel(
      rounds: const IntConverter().fromJson(json['rounds']),
      explain: json['explain'] as String,
      repeats: (json['repeats'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExerciseDescriptionModelToJson(
        ExerciseDescriptionModel instance) =>
    <String, dynamic>{
      'rounds': const IntConverter().toJson(instance.rounds),
      'explain': instance.explain,
      'repeats': instance.repeats,
    };
