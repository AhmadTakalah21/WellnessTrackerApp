// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientItemModel _$IngredientItemModelFromJson(Map<String, dynamic> json) =>
    IngredientItemModel(
      ingredientId: (json['ingredient_id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$IngredientItemModelToJson(
        IngredientItemModel instance) =>
    <String, dynamic>{
      'ingredient_id': instance.ingredientId,
      'quantity': instance.quantity,
    };
