// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsModel _$PointsModelFromJson(Map<String, dynamic> json) => PointsModel(
      totalPoints: (json['total_points'] as num).toInt(),
      chartData: (json['chart_data'] as List<dynamic>)
          .map((e) => PointsChartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PointsModelToJson(PointsModel instance) =>
    <String, dynamic>{
      'total_points': instance.totalPoints,
      'chart_data': instance.chartData,
    };
