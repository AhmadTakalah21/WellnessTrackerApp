// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealPlanModel _$MealPlanModelFromJson(Map<String, dynamic> json) =>
    MealPlanModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      dietitianId: (json['dietitian_id'] as num).toInt(),
      planDays: (json['plan_days'] as List<dynamic>)
          .map((e) => PlanDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealPlanModelToJson(MealPlanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dietitian_id': instance.dietitianId,
      'plan_days': instance.planDays,
    };
