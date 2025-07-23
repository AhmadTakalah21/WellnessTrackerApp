// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_with_quantity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientWithQuantityModel _$IngredientWithQuantityModelFromJson(
        Map<String, dynamic> json) =>
    IngredientWithQuantityModel(
      id: (json['id'] as num).toInt(),
      ingredientId: (json['ingredient_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      ingredient:
          IngredientModel.fromJson(json['ingredient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IngredientWithQuantityModelToJson(
        IngredientWithQuantityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ingredient_id': instance.ingredientId,
      'quantity': instance.quantity,
      'ingredient': instance.ingredient,
    };
