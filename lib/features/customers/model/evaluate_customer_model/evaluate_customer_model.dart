import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'evaluate_customer_model.g.dart';

@JsonSerializable()
@immutable
class EvaluateCustomerModel {
  const EvaluateCustomerModel({
    this.health,
    this.psychology,
    this.behavior,
    this.plansCount,
    this.coachId,
    this.doctorId,
    this.dietitianId,
    this.psychologistId,
  });

  // ✅ اختيارية + لا تُرسل إذا null
  @JsonKey(includeIfNull: false)
  final String? health;

  @JsonKey(includeIfNull: false)
  final String? psychology;

  @JsonKey(includeIfNull: false)
  final String? behavior;

  // ✅ المفتاح الصحيح + لا يُرسل إذا null
  @JsonKey(name: "plans_count", includeIfNull: false)
  final int? plansCount;

  // ✅ لمعرفة التقييم من أي موظف + لا تُرسل إذا null
  @JsonKey(name: "coach_id", includeIfNull: false)
  final int? coachId;

  @JsonKey(name: "doctor_id", includeIfNull: false)
  final int? doctorId;

  @JsonKey(name: "dietitian_id", includeIfNull: false)
  final int? dietitianId;

  @JsonKey(name: "psychologist_id", includeIfNull: false)
  final int? psychologistId;

  EvaluateCustomerModel copyWith({
    String? Function()? health,
    String? Function()? psychology,
    String? Function()? behavior,
    int? Function()? plansCount,
    int? Function()? coachId,
    int? Function()? doctorId,
    int? Function()? dietitianId,
    int? Function()? psychologistId,
  }) {
    return EvaluateCustomerModel(
      health: health != null ? health() : this.health,
      psychology: psychology != null ? psychology() : this.psychology,
      behavior: behavior != null ? behavior() : this.behavior,
      plansCount: plansCount != null ? plansCount() : this.plansCount,
      coachId: coachId != null ? coachId() : this.coachId,
      doctorId: doctorId != null ? doctorId() : this.doctorId,
      dietitianId: dietitianId != null ? dietitianId() : this.dietitianId,
      psychologistId:
      psychologistId != null ? psychologistId() : this.psychologistId,
    );
  }

  // ✅ تحقق اختياري حسب الدور
  String requireHealth() {
    if (health == null || health!.trim().isEmpty) throw "health_required".tr();
    return health!;
  }

  String requirePsychology() {
    if (psychology == null || psychology!.trim().isEmpty) {
      throw "psychology_required".tr();
    }
    return psychology!;
  }

  String requireBehavior() {
    if (behavior == null || behavior!.trim().isEmpty) {
      throw "behavior_required".tr();
    }
    return behavior!;
  }

  int requirePlansCount() {
    if (plansCount == null) throw "plans_count_required".tr();
    return plansCount!;
  }

  factory EvaluateCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$EvaluateCustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluateCustomerModelToJson(this);

  factory EvaluateCustomerModel.fromString(String jsonString) =>
      EvaluateCustomerModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
