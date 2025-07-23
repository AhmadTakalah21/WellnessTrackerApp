import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_with_quantity_model/ingredient_with_quantity_model.dart';
import 'package:wellnesstrackerapp/global/models/meal_type_enum.dart';

part 'meal_model.g.dart';

@JsonSerializable()
@immutable
class MealModel {
  const MealModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.link,
    required this.dietitianId,
    required this.ingredients,
  });

  final int id;
  final String name;
  final String description;

  @JsonKey(fromJson: MealTypeEnum.fromJson, toJson: MealTypeEnum.toJson)
  final MealTypeEnum type;
  final String link;

  @JsonKey(name: 'dietitian_id')
  final int dietitianId;

  final List<IngredientWithQuantityModel> ingredients;

  factory MealModel.fromString(String str) =>
      MealModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
