// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_points_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPointsModel _$AddPointsModelFromJson(Map<String, dynamic> json) =>
    AddPointsModel(
      subscribers: (json['subscribers'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      points: json['points'] as String?,
    );

Map<String, dynamic> _$AddPointsModelToJson(AddPointsModel instance) =>
    <String, dynamic>{
      'subscribers': instance.subscribers,
      'points': instance.points,
    };
