// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_evaluation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerEvaluationModel _$CustomerEvaluationModelFromJson(
        Map<String, dynamic> json) =>
    CustomerEvaluationModel(
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      length: (json['length'] as num).toDouble(),
      weightBeforeSubscription:
          (json['weight_before_subscription'] as num).toDouble(),
      healthEvaluation: json['health_evaluation'] as String,
      psycologyEvaluation: json['psycology_evaluation'] as String,
      behaviorEvaluation: json['behavior_evaluation'] as String,
      currentWeight: (json['current_weight'] as num).toDouble(),
      receivedPlansCount: (json['received_plans_count'] as num).toInt(),
    );

Map<String, dynamic> _$CustomerEvaluationModelToJson(
        CustomerEvaluationModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'length': instance.length,
      'weight_before_subscription': instance.weightBeforeSubscription,
      'health_evaluation': instance.healthEvaluation,
      'psycology_evaluation': instance.psycologyEvaluation,
      'behavior_evaluation': instance.behaviorEvaluation,
      'current_weight': instance.currentWeight,
      'received_plans_count': instance.receivedPlansCount,
    };
