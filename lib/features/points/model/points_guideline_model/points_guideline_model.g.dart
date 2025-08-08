// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_guideline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsGuidelineModel _$PointsGuidelineModelFromJson(
        Map<String, dynamic> json) =>
    PointsGuidelineModel(
      id: (json['id'] as num).toInt(),
      isActive: const BoolConverter().fromJson(json['is_active']),
      title: EnArModel.fromJson(json['title'] as Map<String, dynamic>),
      description:
          EnArModel.fromJson(json['description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PointsGuidelineModelToJson(
        PointsGuidelineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_active': const BoolConverter().toJson(instance.isActive),
      'title': instance.title,
      'description': instance.description,
    };
