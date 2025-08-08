import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'points_chart_model.g.dart';

@JsonSerializable()
@immutable
class PointsChartModel {
  const PointsChartModel({
    required this.month,
    required this.points,
  });

  final String month;
  final int points;

  factory PointsChartModel.fromJson(Map<String, dynamic> json) =>
      _$PointsChartModelFromJson(json);

  Map<String, dynamic> toJson() => _$PointsChartModelToJson(this);

  factory PointsChartModel.fromString(String jsonString) =>
      PointsChartModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
