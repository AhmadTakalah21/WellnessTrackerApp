import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';

part 'plan_day_model.g.dart';

@JsonSerializable()
@immutable
class PlanDayModel {
  const PlanDayModel({
    required this.id,
    required this.day,
    required this.meals,
  });

  final int id;

  @JsonKey(fromJson: DayEnum.fromJson, toJson: DayEnum.toJson)
  final DayEnum day;

  final List<MealModel> meals;

  factory PlanDayModel.fromJson(Map<String, dynamic> json) =>
      _$PlanDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlanDayModelToJson(this);

  factory PlanDayModel.fromString(String jsonStr) =>
      PlanDayModel.fromJson(json.decode(jsonStr));

  @override
  String toString() => jsonEncode(toJson());
}
