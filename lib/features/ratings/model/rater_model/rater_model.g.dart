// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rater_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RaterModel _$RaterModelFromJson(Map<String, dynamic> json) => RaterModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$RaterModelToJson(RaterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
