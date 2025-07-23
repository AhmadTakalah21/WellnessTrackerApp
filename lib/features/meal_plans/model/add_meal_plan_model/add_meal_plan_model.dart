import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_item_model/plan_day_item_model.dart';

part 'add_meal_plan_model.g.dart';

@JsonSerializable()
@immutable
class AddMealPlanModel {
  const AddMealPlanModel({
    String? name,
    List<PlanDayItemModel>? planDays,
  })  : _name = name,
        _planDays = planDays;

  final String? _name;
  final List<PlanDayItemModel>? _planDays;

  AddMealPlanModel copyWith({
    String? Function()? name,
    List<PlanDayItemModel>? Function()? planDays,
  }) {
    return AddMealPlanModel(
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
  List<PlanDayItemModel> get planDays {
    if (_planDays == null || _planDays.isEmpty) {
      throw "plan_days_required".tr();
    }
    return _planDays;
  }

  factory AddMealPlanModel.fromJson(Map<String, dynamic> json) =>
      _$AddMealPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddMealPlanModelToJson(this);

  factory AddMealPlanModel.fromString(String jsonString) =>
      AddMealPlanModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
