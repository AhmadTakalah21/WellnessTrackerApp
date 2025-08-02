import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_day_model/exercise_plan_day_model.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

part 'exercise_plan_model.g.dart';

@JsonSerializable()
@immutable
class ExercisePlanModel implements DropDownItemModel, DeleteModel {
  const ExercisePlanModel({
    required this.id,
    required this.name,
    required this.coachId,
    this.planDays = const [],
  });

  @override
  final int id;
  final String name;

  @JsonKey(name: 'coach_id')
  final int coachId;

  @JsonKey(name: 'days')
  final List<ExercisePlanDayModel> planDays;

  factory ExercisePlanModel.fromJson(Map<String, dynamic> json) =>
      _$ExercisePlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisePlanModelToJson(this);

  factory ExercisePlanModel.fromString(String jsonStr) =>
      ExercisePlanModel.fromJson(json.decode(jsonStr));

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get displayEntityName => name;

  @override
  String get displayName => name;

  @override
  String get apiDeleteUrl => "v1/coach/exercise-plans/$id";
}
