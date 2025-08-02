// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:wellnesstrackerapp/global/models/day_enum.dart';

part 'exercise_plan_day_item_model.g.dart';

@JsonSerializable()
@immutable
class ExercisePlanDayItemModel {
  const ExercisePlanDayItemModel({
    required this.day,
    this.exercises = const [],
  });

  @JsonKey(fromJson: DayEnum.fromJson, toJson: DayEnum.toJson)
  final DayEnum day;

  final List<int>? exercises;

  factory ExercisePlanDayItemModel.fromJson(Map<String, dynamic> json) =>
      _$ExercisePlanDayItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisePlanDayItemModelToJson(this);

  factory ExercisePlanDayItemModel.fromString(String jsonStr) =>
      ExercisePlanDayItemModel.fromJson(json.decode(jsonStr));

  @override
  String toString() => jsonEncode(toJson());

  ExercisePlanDayItemModel copyWith({
    DayEnum? Function()? day,
    List<int>? Function()? exercises,
  }) {
    return ExercisePlanDayItemModel(
      day: this.day,
      exercises: exercises != null ? exercises() : this.exercises,
    );
  }
}
