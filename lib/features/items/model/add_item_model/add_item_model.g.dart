// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddItemModel _$AddItemModelFromJson(Map<String, dynamic> json) => AddItemModel(
  nameAr: json['nameAr'] as String?,
  nameEn: json['nameEn'] as String?,
  price: json['price'] as String?,
  descriptionEn: json['descriptionEn'] as String?,
  descriptionAr: json['descriptionAr'] as String?,
);

Map<String, dynamic> _$AddItemModelToJson(AddItemModel instance) =>
    <String, dynamic>{
      'nameAr': instance.nameAr,
      'nameEn': instance.nameEn,
      'price': instance.price,
      'descriptionEn': instance.descriptionEn,
      'descriptionAr': instance.descriptionAr,
    };
