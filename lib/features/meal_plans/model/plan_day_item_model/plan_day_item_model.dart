import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';

part 'plan_day_item_model.g.dart';

@JsonSerializable()
@immutable
class PlanDayItemModel {
  const PlanDayItemModel({
    required this.day,
    required this.meals,
  });

  @JsonKey(fromJson: DayEnum.fromJson, toJson: DayEnum.toJson)
  final DayEnum day;

  final List<int> meals;

  factory PlanDayItemModel.fromJson(Map<String, dynamic> json) =>
      _$PlanDayItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlanDayItemModelToJson(this);

  factory PlanDayItemModel.fromString(String jsonStr) =>
      PlanDayItemModel.fromJson(json.decode(jsonStr));

  @override
  String toString() => jsonEncode(toJson());
}
