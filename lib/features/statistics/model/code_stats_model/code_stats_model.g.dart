// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeStatsModel _$CodeStatsModelFromJson(Map<String, dynamic> json) =>
    CodeStatsModel(
      code: json['code'] as String,
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$CodeStatsModelToJson(CodeStatsModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'total': instance.total,
    };
