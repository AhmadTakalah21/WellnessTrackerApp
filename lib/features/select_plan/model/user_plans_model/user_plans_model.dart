import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/features/select_plan/model/user_plan_model/user_plan_model.dart';

part 'user_plans_model.g.dart';

@JsonSerializable()
@immutable
class UserPlansModel {
  const UserPlansModel({required this.plans});
  final List<UserPlanModel> plans;

  factory UserPlansModel.fromString(String str) =>
      UserPlansModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory UserPlansModel.fromJson(Map<String, dynamic> json) =>
      _$UserPlansModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPlansModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
