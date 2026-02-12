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
      coachId: (json['coach_id'] as num?)?.toInt(),
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      dietitianId: (json['dietitian_id'] as num?)?.toInt(),
      psychologistId: (json['psychologist_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EvaluateCustomerModelToJson(
        EvaluateCustomerModel instance) =>
    <String, dynamic>{
      if (instance.health case final value?) 'health': value,
      if (instance.psychology case final value?) 'psychology': value,
      if (instance.behavior case final value?) 'behavior': value,
      if (instance.plansCount case final value?) 'plans_count': value,
      if (instance.coachId case final value?) 'coach_id': value,
      if (instance.doctorId case final value?) 'doctor_id': value,
      if (instance.dietitianId case final value?) 'dietitian_id': value,
      if (instance.psychologistId case final value?) 'psychologist_id': value,
    };
