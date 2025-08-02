// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_plan_day_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisePlanDayItemModel _$ExercisePlanDayItemModelFromJson(
        Map<String, dynamic> json) =>
    ExercisePlanDayItemModel(
      day: DayEnum.fromJson(json['day']),
      exercises: (json['exercises'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExercisePlanDayItemModelToJson(
        ExercisePlanDayItemModel instance) =>
    <String, dynamic>{
      'day': DayEnum.toJson(instance.day),
      'exercises': instance.exercises,
    };
