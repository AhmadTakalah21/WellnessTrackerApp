import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'code_stats_model.g.dart';

@JsonSerializable()
@immutable
class CodeStatsModel {
  const CodeStatsModel({
    required this.code,
    required this.total,
  });

  final String code;
  final int total;

  factory CodeStatsModel.fromString(String str) =>
      CodeStatsModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory CodeStatsModel.fromJson(Map<String, dynamic> json) =>
      _$CodeStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CodeStatsModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
