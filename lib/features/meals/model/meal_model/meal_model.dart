import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_with_quantity_model/ingredient_with_quantity_model.dart';
import 'package:wellnesstrackerapp/global/models/meal_type_enum.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

part 'meal_model.g.dart';

@JsonSerializable()
@immutable
class MealModel implements DropDownItemModel, DeleteModel {
  const MealModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.link,
    required this.dietitianId,
    this.ingredients = const [],
  });

  @override
  final int id;
  final String name;
  final String description;

  @JsonKey(fromJson: MealTypeEnum.fromJson, toJson: MealTypeEnum.toJson)
  final MealTypeEnum type;
  final String link;

  @JsonKey(name: 'dietitian_id')
  final int dietitianId;

  @JsonKey(defaultValue: [])
  final List<IngredientWithQuantityModel> ingredients;

  factory MealModel.fromString(String str) =>
      MealModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get displayEntityName => name;

  @override
  String get displayName => name;

  @override
  String get apiDeleteUrl => "v1/dietitian/meals/$id";
}
