import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/global/models/en_ar_model/en_ar_model.dart';
import 'package:wellnesstrackerapp/global/utils/json_converters/bool_converter.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';

part 'points_guideline_model.g.dart';

@JsonSerializable()
@immutable
class PointsGuidelineModel implements DeleteModel {
  const PointsGuidelineModel({
    required this.id,
    required this.isActive,
    required this.title,
    required this.description,
  });

  final int id;

  @BoolConverter()
  @JsonKey(name: "is_active")
  final bool isActive;

  final EnArModel title;
  final EnArModel description;

  factory PointsGuidelineModel.fromJson(Map<String, dynamic> json) =>
      _$PointsGuidelineModelFromJson(json);

  Map<String, dynamic> toJson() => _$PointsGuidelineModelToJson(this);

  factory PointsGuidelineModel.fromString(String jsonString) =>
      PointsGuidelineModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/v1/admin/guidelines/$id";
}
