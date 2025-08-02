// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMealModel _$AddMealModelFromJson(Map<String, dynamic> json) => AddMealModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      type: MealTypeEnum.fromJson(json['type']),
      link: json['link'] as String?,
      file: json['link_file'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => IngredientItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddMealModelToJson(AddMealModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': MealTypeEnum.toJson(instance.type),
      'link': instance.link,
      'link_file': Utils.nullableFileToJson(instance.file),
    };
