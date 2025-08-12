import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';

part 'user_plan_model.g.dart';

@JsonSerializable()
@immutable
class UserPlanModel {
  const UserPlanModel({
    required this.department,
    required this.phone,
  });
  
  @JsonKey(
    fromJson: DepartmentEnum.fromJson,
    toJson: DepartmentEnum.toJson,
  )
  final DepartmentEnum department;
  final String phone;

  factory UserPlanModel.fromString(String str) =>
      UserPlanModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory UserPlanModel.fromJson(Map<String, dynamic> json) =>
      _$UserPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPlanModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
