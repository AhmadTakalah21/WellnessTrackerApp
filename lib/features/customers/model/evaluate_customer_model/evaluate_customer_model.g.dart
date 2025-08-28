// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluate_customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EvaluateCustomerModel _$EvaluateCustomerModelFromJson(
        Map<String, dynamic> json) =>
    EvaluateCustomerModel(
      health: json['health'] as String?,
      psychology: json['psychology'] as String?,
      behavior: json['behavior'] as String?,
      plansCount: (json['plans_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EvaluateCustomerModelToJson(
        EvaluateCustomerModel instance) =>
    <String, dynamic>{
      'health': instance.health,
      'psychology': instance.psychology,
      'behavior': instance.behavior,
      'plans_count': instance.plansCount,
    };
