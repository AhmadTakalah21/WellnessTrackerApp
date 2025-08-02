import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';

part 'exercise_plan_day_model.g.dart';

@JsonSerializable()
@immutable
class ExercisePlanDayModel {
  const ExercisePlanDayModel({
    required this.id,
    required this.day,
     this.exercises =const [],
  });

  final int id;

  @JsonKey(fromJson: DayEnum.fromJson, toJson: DayEnum.toJson)
  final DayEnum day;

  final List<ExerciseModel> exercises;

  factory ExercisePlanDayModel.fromJson(Map<String, dynamic> json) =>
      _$ExercisePlanDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisePlanDayModelToJson(this);

  factory ExercisePlanDayModel.fromString(String jsonStr) =>
      ExercisePlanDayModel.fromJson(json.decode(jsonStr));

  @override
  String toString() => jsonEncode(toJson());
}
