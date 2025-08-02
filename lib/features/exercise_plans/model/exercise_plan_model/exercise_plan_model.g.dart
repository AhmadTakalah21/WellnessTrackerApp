// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisePlanModel _$ExercisePlanModelFromJson(Map<String, dynamic> json) =>
    ExercisePlanModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      coachId: (json['coach_id'] as num).toInt(),
      planDays: (json['days'] as List<dynamic>?)
              ?.map((e) =>
                  ExercisePlanDayModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExercisePlanModelToJson(ExercisePlanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coach_id': instance.coachId,
      'days': instance.planDays,
    };
