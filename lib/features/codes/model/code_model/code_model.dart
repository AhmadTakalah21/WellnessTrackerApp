import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/features/codes/model/department_model/department_model.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';

part 'code_model.g.dart';

@JsonSerializable()
@immutable
class CodeModel implements DeleteModel {
  const CodeModel({
    required this.id,
    required this.code,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.department,
  });

  final int id;
  final String code;

  @JsonKey(name: 'start_date')
  final String startDate;

  @JsonKey(name: 'end_date')
  final String endDate;

  final String status;
  final DepartmentModel department;

  factory CodeModel.fromString(String str) =>
      CodeModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory CodeModel.fromJson(Map<String, dynamic> json) =>
      _$CodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CodeModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/code/$id";
}
