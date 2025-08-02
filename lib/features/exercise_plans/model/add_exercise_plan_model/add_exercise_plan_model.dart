import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_day_item_model/exercise_plan_day_item_model.dart';

part 'add_exercise_plan_model.g.dart';

@JsonSerializable()
@immutable
class AddExercisePlanModel {
  const AddExercisePlanModel({
    String? name,
    List<ExercisePlanDayItemModel>? planDays,
  })  : _name = name,
        _planDays = planDays;

  final String? _name;
  final List<ExercisePlanDayItemModel>? _planDays;

  AddExercisePlanModel copyWith({
    String? Function()? name,
    List<ExercisePlanDayItemModel>? Function()? planDays,
  }) {
    return AddExercisePlanModel(
      name: name != null ? name() : _name,
      planDays: planDays != null ? planDays() : _planDays,
    );
  }

  String get name {
    if (_name == null || _name.isEmpty) {
      throw "name_required".tr();
    }
    return _name;
  }

  @JsonKey(name: 'plan_days')
  List<ExercisePlanDayItemModel> get planDays {
    if (_planDays == null || _planDays.isEmpty) {
      throw "plan_days_required".tr();
    }
    return _planDays;
  }

  factory AddExercisePlanModel.fromJson(Map<String, dynamic> json) =>
      _$AddExercisePlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddExercisePlanModelToJson(this);

  factory AddExercisePlanModel.fromString(String jsonString) =>
      AddExercisePlanModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
