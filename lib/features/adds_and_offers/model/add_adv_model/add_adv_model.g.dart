// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_adv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAdvModel _$AddAdvModelFromJson(Map<String, dynamic> json) => AddAdvModel(
      titleEn: json['title[en]'] as String?,
      titleAr: json['title[ar]'] as String?,
      descriptionEn: json['description[en]'] as String?,
      descriptionAr: json['description[ar]'] as String?,
      type: AdvTypeEnum.fromJson((json['type'] as num).toInt()),
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$AddAdvModelToJson(AddAdvModel instance) =>
    <String, dynamic>{
      'title[en]': instance.titleEn,
      'title[ar]': instance.titleAr,
      'description[en]': instance.descriptionEn,
      'description[ar]': instance.descriptionAr,
      'type': AdvTypeEnum.toJson(instance.type),
      'end_date': instance.endDate,
    };
