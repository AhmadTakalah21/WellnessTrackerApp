// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealModel _$MealModelFromJson(Map<String, dynamic> json) => MealModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      type: MealTypeEnum.fromJson(json['type']),
      link: json['link'] as String,
      dietitianId: (json['dietitian_id'] as num).toInt(),
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => IngredientWithQuantityModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MealModelToJson(MealModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': MealTypeEnum.toJson(instance.type),
      'link': instance.link,
      'dietitian_id': instance.dietitianId,
      'ingredients': instance.ingredients,
    };
