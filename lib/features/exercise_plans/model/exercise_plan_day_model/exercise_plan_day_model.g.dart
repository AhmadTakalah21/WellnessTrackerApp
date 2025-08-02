// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_plan_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisePlanDayModel _$ExercisePlanDayModelFromJson(
        Map<String, dynamic> json) =>
    ExercisePlanDayModel(
      id: (json['id'] as num).toInt(),
      day: DayEnum.fromJson(json['day']),
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExercisePlanDayModelToJson(
        ExercisePlanDayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': DayEnum.toJson(instance.day),
      'exercises': instance.exercises,
    };
