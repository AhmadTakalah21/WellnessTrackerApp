import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/models/ingredient_unit_enum.dart';

part 'ingredient_model.g.dart';

@JsonSerializable()
@immutable
class IngredientModel implements DeleteModel, DropDownItemModel {
  const IngredientModel({
    required this.id,
    required this.name,
    required this.unit,
    required this.calories,
    required this.carbs,
    required this.proteins,
    required this.dietitianId,
  });

  @override
  final int id;
  final String name;

  @JsonKey(
    fromJson: IngredientUnitEnum.fromJson,
    toJson: IngredientUnitEnum.toJson,
  )
  final IngredientUnitEnum unit;

  final String calories;
  final String carbs;
  final String proteins;

  @JsonKey(name: 'dietitian_id')
  final int dietitianId;

  factory IngredientModel.fromString(String str) =>
      IngredientModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/v1/admin/ingredients/$id";

  @override
  String get displayName => name;

  @override
  String get displayEntityName => name;
}
