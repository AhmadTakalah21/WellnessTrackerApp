import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'department_model.g.dart';

@JsonSerializable()
@immutable
class DepartmentModel {
  const DepartmentModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory DepartmentModel.fromString(String str) =>
      DepartmentModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
