// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddItemModel _$AddItemModelFromJson(Map<String, dynamic> json) => AddItemModel(
      name: json['name'] == null
          ? null
          : EnArAddModel.fromJson(json['name'] as Map<String, dynamic>),
      description: json['description'] == null
          ? null
          : EnArAddModel.fromJson(json['description'] as Map<String, dynamic>),
      link: json['link'] as String?,
      price: json['price'] as String?,
      levelId: (json['level_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddItemModelToJson(AddItemModel instance) =>
    <String, dynamic>{
      'name': instance.name.toJson(),
      'description': instance.description?.toJson(),
      'link': instance.link,
      'price': instance.price,
      'level_id': instance.levelId,
    };
