// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_adv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAdvModel _$AddAdvModelFromJson(Map<String, dynamic> json) => AddAdvModel(
      title: json['title'] == null
          ? null
          : EnArAddModel.fromJson(json['title'] as Map<String, dynamic>),
      description: json['description'] == null
          ? null
          : EnArAddModel.fromJson(json['description'] as Map<String, dynamic>),
      type: AdvTypeEnum.fromJson((json['type'] as num).toInt()),
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$AddAdvModelToJson(AddAdvModel instance) =>
    <String, dynamic>{
      'title': instance.title.toJson(),
      'description': instance.description?.toJson(),
      'type': AdvTypeEnum.toJson(instance.type),
      'end_date': instance.endDate,
    };
