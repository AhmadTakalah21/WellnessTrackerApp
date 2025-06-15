import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

part 'user_role_model.g.dart';

@JsonSerializable()
@immutable
class UserRoleModel implements DropDownItemModel {
  const UserRoleModel({
    required this.id,
    required this.name,
  });

  @override
  final int id;
  final String name;

  factory UserRoleModel.fromString(String str) =>
      UserRoleModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory UserRoleModel.fromJson(Map<String, dynamic> json) =>
      _$UserRoleModelFromJson(json);

  @override
  String toString() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => _$UserRoleModelToJson(this);

  @override
  String get displayName => name;
}
