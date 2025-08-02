// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_exercise_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddExercisePlanModel _$AddExercisePlanModelFromJson(
        Map<String, dynamic> json) =>
    AddExercisePlanModel(
      name: json['name'] as String?,
      planDays: (json['plan_days'] as List<dynamic>?)
          ?.map((e) =>
              ExercisePlanDayItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddExercisePlanModelToJson(
        AddExercisePlanModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'plan_days': instance.planDays,
    };
