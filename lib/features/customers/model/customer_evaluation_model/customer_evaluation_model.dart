import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'customer_evaluation_model.g.dart';

@JsonSerializable()
@immutable
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
    this.coachId,
    this.doctorId,
    this.dietitianId,
    this.psychologistId,
  });

  final String name;
  final int age;
  final num length;

  @JsonKey(name: 'weight_before_subscription')
  final num weightBeforeSubscription;

  @JsonKey(name: 'health_evaluation')
  final String? healthEvaluation;

  @JsonKey(name: 'psycology_evaluation')
  final String? psycologyEvaluation;

  @JsonKey(name: 'behavior_evaluation')
  final String? behaviorEvaluation;

  @JsonKey(name: 'current_weight')
  final num currentWeight;

  @JsonKey(name: 'received_plans_count')
  final int receivedPlansCount;

  // ✅ NEW: لمعرفة من قيّم
  @JsonKey(name: 'coach_id')
  final int? coachId;

  @JsonKey(name: 'doctor_id')
  final int? doctorId;

  @JsonKey(name: 'dietitian_id')
  final int? dietitianId;

  @JsonKey(name: 'psychologist_id')
  final int? psychologistId;

  factory CustomerEvaluationModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerEvaluationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerEvaluationModelToJson(this);

  factory CustomerEvaluationModel.fromString(String str) =>
      CustomerEvaluationModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  @override
  String toString() => jsonEncode(toJson());
}
