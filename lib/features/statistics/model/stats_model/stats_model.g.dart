// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatsModel _$StatsModelFromJson(Map<String, dynamic> json) => StatsModel(
      activeUsers: (json['active_users'] as num).toInt(),
      dietitianUsers: (json['dietitian_users'] as num).toInt(),
      exerciseUsers: (json['exercise_users'] as num).toInt(),
      maleUsers: (json['male_users'] as num).toInt(),
      femaleUsers: (json['female_users'] as num).toInt(),
      avgAgesUsers: (json['avg_ages_users'] as num).toDouble(),
      avgWeightsUsers: (json['avg_weights_users'] as num).toDouble(),
      avgLengthsUsers: (json['avg_lengths_users'] as num).toDouble(),
    );

Map<String, dynamic> _$StatsModelToJson(StatsModel instance) =>
    <String, dynamic>{
      'active_users': instance.activeUsers,
      'dietitian_users': instance.dietitianUsers,
      'exercise_users': instance.exerciseUsers,
      'male_users': instance.maleUsers,
      'female_users': instance.femaleUsers,
      'avg_ages_users': instance.avgAgesUsers,
      'avg_weights_users': instance.avgWeightsUsers,
      'avg_lengths_users': instance.avgLengthsUsers,
    };
