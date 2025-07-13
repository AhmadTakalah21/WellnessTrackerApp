// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: (json['id'] as num).toInt(),
      name: EnArModel.fromJson(json['name'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
      description: json['description'] == null
          ? null
          : EnArModel.fromJson(json['description'] as Map<String, dynamic>),
      link: json['link'] as String?,
      level: LevelModel.fromJson(json['level'] as Map<String, dynamic>),
      image: json['image_path'] as String?,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'link': instance.link,
      'level': instance.level,
      'image_path': instance.image,
    };
