import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient_item_model.g.dart';

@JsonSerializable()
@immutable
class IngredientItemModel {
  const IngredientItemModel({
    this.ingredientId,
    this.quantity,
  });

  @JsonKey(name: 'ingredient_id')
  final int? ingredientId;
  final int? quantity;

  IngredientItemModel copyWith({
    int? Function()? ingredientId,
    int? Function()? quantity
  }) {
    return IngredientItemModel(
      ingredientId: ingredientId != null ? ingredientId() : this.ingredientId,
      quantity: quantity != null ? quantity() : this.quantity,
    );
  }

  factory IngredientItemModel.fromString(String str) =>
      IngredientItemModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory IngredientItemModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientItemModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
