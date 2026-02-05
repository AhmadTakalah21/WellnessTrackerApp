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
      plansCount: (json['plansCount'] as num?)?.toInt(),
      coachId: (json['coachId'] as num?)?.toInt(),
      doctorId: (json['doctorId'] as num?)?.toInt(),
      dietitianId: (json['dietitianId'] as num?)?.toInt(),
      psychologistId: (json['psychologistId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EvaluateCustomerModelToJson(
        EvaluateCustomerModel instance) =>
    <String, dynamic>{
      if (instance.health case final value?) 'health': value,
      if (instance.psychology case final value?) 'psychology': value,
      if (instance.behavior case final value?) 'behavior': value,
      'plansCount': instance.plansCount,
      'coachId': instance.coachId,
      'doctorId': instance.doctorId,
      'dietitianId': instance.dietitianId,
      'psychologistId': instance.psychologistId,
    };
