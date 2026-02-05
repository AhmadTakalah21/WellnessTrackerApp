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
    @JsonKey(name: "plans_count", includeIfNull: false) this.plansCount,

    // ✅ لمعرفة التقييم من أي موظف (اختياري)
    @JsonKey(name: "coach_id", includeIfNull: false) this.coachId,
    @JsonKey(name: "doctor_id", includeIfNull: false) this.doctorId,
    @JsonKey(name: "dietitian_id", includeIfNull: false) this.dietitianId,
    @JsonKey(name: "psychologist_id", includeIfNull: false) this.psychologistId,
  });

  // ✅ صارت nullable واختيارية
  @JsonKey(includeIfNull: false)
  final String? health;

  @JsonKey(includeIfNull: false)
  final String? psychology;

  @JsonKey(includeIfNull: false)
  final String? behavior;

  // موجودة فوق مع name plans_count
  final int? plansCount;

  // ✅ حقول الموظف (اختيارية)
  final int? coachId;
  final int? doctorId;
  final int? dietitianId;
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

  // ✅ دوال تحقق تستخدمها فقط إذا بدك تجعل الحقل مطلوب حسب الدور
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
