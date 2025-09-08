// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/features/select_plan/model/user_plan_model/user_plan_model.dart';

part 'user_plans_model.g.dart';

@JsonSerializable()
@immutable
class UserPlansModel {
  const UserPlansModel({
    required this.plans,
    this.emergenciesPhone,
  });
  final List<UserPlanModel> plans;

  @JsonKey(name: "emergencies_phone")
  final String? emergenciesPhone;

  factory UserPlansModel.fromString(String str) =>
      UserPlansModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory UserPlansModel.fromJson(Map<String, dynamic> json) =>
      _$UserPlansModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPlansModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
