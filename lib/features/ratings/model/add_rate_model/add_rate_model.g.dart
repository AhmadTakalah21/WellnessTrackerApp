// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRateModel _$AddRateModelFromJson(Map<String, dynamic> json) => AddRateModel(
      rating: (json['rating'] as num?)?.toInt() ?? 2,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$AddRateModelToJson(AddRateModel instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'comment': instance.comment,
    };
