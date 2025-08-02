import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';

part 'ingredient_with_quantity_model.g.dart';

@JsonSerializable()
@immutable
class IngredientWithQuantityModel {
  const IngredientWithQuantityModel({
    required this.id,
    required this.quantity,
    required this.ingredient,
  });

  final int id;
  final int quantity;
  final IngredientModel ingredient;

  factory IngredientWithQuantityModel.fromString(String str) =>
      IngredientWithQuantityModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory IngredientWithQuantityModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientWithQuantityModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientWithQuantityModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
