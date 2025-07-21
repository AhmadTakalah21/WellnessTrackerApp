// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddIngredientModel _$AddIngredientModelFromJson(Map<String, dynamic> json) =>
    AddIngredientModel(
      name: json['name'] as String?,
      unit: IngredientUnitEnum.fromJson((json['unit'] as num).toInt()),
      calories: json['calories'] as String?,
      carbs: json['carbs'] as String?,
      proteins: json['proteins'] as String?,
    );

Map<String, dynamic> _$AddIngredientModelToJson(AddIngredientModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'unit': IngredientUnitEnum.toJson(instance.unit),
      'calories': instance.calories,
      'carbs': instance.carbs,
      'proteins': instance.proteins,
    };
