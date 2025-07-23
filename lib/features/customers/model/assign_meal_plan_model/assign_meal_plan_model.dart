import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part "assign_meal_plan_model.g.dart";

@JsonSerializable()
@immutable
class AssignMealPlanModel {
  const AssignMealPlanModel({
    List<int>? users = const [],
    int? planId,
  })  : _users = users,
        _planId = planId;

  final List<int>? _users;
  final int? _planId;

  AssignMealPlanModel copyWith({
    List<int>? Function()? users,
    int? Function()? planId,
  }) {
    return AssignMealPlanModel(
      users: users != null ? users() : _users,
      planId: planId != null ? planId() : _planId,
    );
  }

  List<int> get users {
    if (_users == null || _users.isEmpty) {
      throw "at_least_one_subscriber".tr();
    }
    return _users;
  }

  @JsonKey(name: "plan_id")
  int get planId {
    if (_planId == null) {
      throw "planId_required".tr();
    }
    return _planId;
  }

  factory AssignMealPlanModel.fromJson(Map<String, dynamic> json) =>
      _$AssignMealPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignMealPlanModelToJson(this);

  factory AssignMealPlanModel.fromString(String jsonString) =>
      AssignMealPlanModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
