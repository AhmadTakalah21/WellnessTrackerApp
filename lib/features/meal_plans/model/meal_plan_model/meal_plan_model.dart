import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_model/plan_day_model.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

part 'meal_plan_model.g.dart';

@JsonSerializable()
@immutable
class MealPlanModel implements DropDownItemModel{
  const MealPlanModel({
    required this.id,
    required this.name,
    required this.dietitianId,
    required this.planDays,
  });

  @override
  final int id;
  final String name;

  @JsonKey(name: 'dietitian_id')
  final int dietitianId;

  @JsonKey(name: 'plan_days')
  final List<PlanDayModel> planDays;

  factory MealPlanModel.fromJson(Map<String, dynamic> json) =>
      _$MealPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealPlanModelToJson(this);

  factory MealPlanModel.fromString(String jsonStr) =>
      MealPlanModel.fromJson(json.decode(jsonStr));

  @override
  String toString() => jsonEncode(toJson());
  
  @override
  String get displayEntityName => name;
  
  @override
  String get displayName => name;
}
