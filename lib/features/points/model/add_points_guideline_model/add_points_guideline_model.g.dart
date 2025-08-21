// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_points_guideline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPointsGuidelineModel _$AddPointsGuidelineModelFromJson(
        Map<String, dynamic> json) =>
    AddPointsGuidelineModel(
      title: json['title'] == null
          ? null
          : EnArAddModel.fromJson(json['title'] as Map<String, dynamic>),
      link: json['link'] as String?,
      description: json['description'] == null
          ? null
          : EnArAddModel.fromJson(json['description'] as Map<String, dynamic>),
      isActive: json['is_active'] == null
          ? ActivityStatusEnum.active
          : ActivityStatusEnum.fromJson((json['is_active'] as num).toInt()),
    );

Map<String, dynamic> _$AddPointsGuidelineModelToJson(
        AddPointsGuidelineModel instance) =>
    <String, dynamic>{
      'description': instance.description?.toJson(),
      'link': instance.link,
      'is_active': ActivityStatusEnum.toJson(instance.isActive),
      'title': instance.title.toJson(),
    };
