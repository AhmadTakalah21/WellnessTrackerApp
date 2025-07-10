// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddItemModel _$AddItemModelFromJson(Map<String, dynamic> json) => AddItemModel(
      nameEn: json['name[en]'] as String?,
      nameAr: json['name[ar]'] as String?,
      descriptionEn: json['description[en]'] as String?,
      descriptionAr: json['description[ar]'] as String?,
      link: json['link'] as String?,
      price: json['price'] as String?,
      levelId: (json['level_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddItemModelToJson(AddItemModel instance) =>
    <String, dynamic>{
      'name[en]': instance.nameEn,
      'name[ar]': instance.nameAr,
      'description[en]': instance.descriptionEn,
      'description[ar]': instance.descriptionAr,
      'link': instance.link,
      'price': instance.price,
      'level_id': instance.levelId,
    };
