// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientModel _$IngredientModelFromJson(Map<String, dynamic> json) =>
    IngredientModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      unit: IngredientUnitEnum.fromJson((json['unit'] as num).toInt()),
      calories: json['calories'] as String,
      carbs: json['carbs'] as String,
      proteins: json['proteins'] as String,
      dietitianId: (json['dietitian_id'] as num).toInt(),
    );

Map<String, dynamic> _$IngredientModelToJson(IngredientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': IngredientUnitEnum.toJson(instance.unit),
      'calories': instance.calories,
      'carbs': instance.carbs,
      'proteins': instance.proteins,
      'dietitian_id': instance.dietitianId,
    };
