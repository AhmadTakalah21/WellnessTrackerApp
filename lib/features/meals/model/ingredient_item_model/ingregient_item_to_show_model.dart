import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';

@immutable
class IngredientItemToShowModel {
  const IngredientItemToShowModel({
    required this.ingredient,
    required this.quantity,
  });

  @JsonKey(name: 'ingredient_id')
  final IngredientModel ingredient;
  final int quantity;

  IngredientItemToShowModel copyWith({
    IngredientModel? Function()? ingredient,
    int?  quantity,
  }) {
    return IngredientItemToShowModel(
      ingredient: this.ingredient,
      quantity: quantity ?? this.quantity
    );
  }
}
