// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsChartModel _$PointsChartModelFromJson(Map<String, dynamic> json) =>
    PointsChartModel(
      month: json['month'] as String,
      points: (json['points'] as num).toInt(),
    );

Map<String, dynamic> _$PointsChartModelToJson(PointsChartModel instance) =>
    <String, dynamic>{
      'month': instance.month,
      'points': instance.points,
    };
