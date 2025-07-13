// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvModel _$AdvModelFromJson(Map<String, dynamic> json) => AdvModel(
      id: (json['id'] as num).toInt(),
      title: EnArModel.fromJson(json['title'] as Map<String, dynamic>),
      description:
          EnArModel.fromJson(json['description'] as Map<String, dynamic>),
      type: AdvTypeEnum.fromJson((json['type'] as num).toInt()),
      image: json['image_path'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
    );

Map<String, dynamic> _$AdvModelToJson(AdvModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': AdvTypeEnum.toJson(instance.type),
      'image_path': instance.image,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
    };
