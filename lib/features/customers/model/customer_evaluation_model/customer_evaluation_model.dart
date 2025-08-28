import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'customer_evaluation_model.g.dart';

@immutable
@JsonSerializable()
class CustomerEvaluationModel {
  const CustomerEvaluationModel({
    required this.name,
    required this.age,
    required this.length,
    required this.weightBeforeSubscription,
    required this.healthEvaluation,
    required this.psycologyEvaluation,
    required this.behaviorEvaluation,
    required this.currentWeight,
    required this.receivedPlansCount,
  });

  final String name;
  final int age;
  final double length;

  @JsonKey(name: 'weight_before_subscription')
  final double weightBeforeSubscription;

  @JsonKey(name: 'health_evaluation')
  final String healthEvaluation;

  @JsonKey(name: 'psycology_evaluation')
  final String psycologyEvaluation;

  @JsonKey(name: 'behavior_evaluation')
  final String behaviorEvaluation;

  @JsonKey(name: 'current_weight')
  final double currentWeight;

  @JsonKey(name: 'received_plans_count')
  final int receivedPlansCount;

  factory CustomerEvaluationModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerEvaluationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerEvaluationModelToJson(this);

  factory CustomerEvaluationModel.fromString(String source) =>
      CustomerEvaluationModel.fromJson(
          jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() => jsonEncode(toJson());
}
