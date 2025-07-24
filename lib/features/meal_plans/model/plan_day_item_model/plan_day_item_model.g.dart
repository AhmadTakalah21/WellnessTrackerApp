// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_day_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanDayItemModel _$PlanDayItemModelFromJson(Map<String, dynamic> json) =>
    PlanDayItemModel(
      day: DayEnum.fromJson(json['day']),
      meals: (json['meals'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$PlanDayItemModelToJson(PlanDayItemModel instance) =>
    <String, dynamic>{
      'day': DayEnum.toJson(instance.day),
      'meals': instance.meals,
    };
