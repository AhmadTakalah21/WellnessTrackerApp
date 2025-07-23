// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_meal_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignMealPlanModel _$AssignMealPlanModelFromJson(Map<String, dynamic> json) =>
    AssignMealPlanModel(
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      planId: (json['planId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AssignMealPlanModelToJson(
        AssignMealPlanModel instance) =>
    <String, dynamic>{
      'users': instance.users,
      'planId': instance.planId,
    };
