// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_meal_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMealPlanModel _$AddMealPlanModelFromJson(Map<String, dynamic> json) =>
    AddMealPlanModel(
      name: json['name'] as String?,
      planDays: (json['plan_days'] as List<dynamic>?)
          ?.map((e) => PlanDayItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddMealPlanModelToJson(AddMealPlanModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'plan_days': instance.planDays,
    };
