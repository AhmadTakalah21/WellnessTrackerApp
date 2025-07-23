// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanDayModel _$PlanDayModelFromJson(Map<String, dynamic> json) => PlanDayModel(
      id: (json['id'] as num).toInt(),
      day: DayEnum.fromJson((json['day'] as num).toInt()),
      meals: (json['meals'] as List<dynamic>)
          .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanDayModelToJson(PlanDayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': DayEnum.toJson(instance.day),
      'meals': instance.meals,
    };
