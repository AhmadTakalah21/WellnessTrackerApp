// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_meal_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignPlanModel _$AssignPlanModelFromJson(Map<String, dynamic> json) =>
    AssignPlanModel(
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      planId: (json['plan_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AssignPlanModelToJson(AssignPlanModel instance) =>
    <String, dynamic>{
      'users': instance.users,
      'plan_id': instance.planId,
    };
