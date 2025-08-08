import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/features/points/model/points_chart_model/points_chart_model.dart';

part 'points_model.g.dart';

@JsonSerializable()
@immutable
class PointsModel {
  const PointsModel({
    required this.totalPoints,
    required this.chartData,
  });

  @JsonKey(name: "total_points")
  final int totalPoints;

  @JsonKey(name: "chart_data")
  final List<PointsChartModel> chartData;

  factory PointsModel.fromJson(Map<String, dynamic> json) =>
      _$PointsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PointsModelToJson(this);

  factory PointsModel.fromString(String jsonString) =>
      PointsModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
