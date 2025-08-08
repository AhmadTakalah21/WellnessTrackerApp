// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCodeModel _$AddCodeModelFromJson(Map<String, dynamic> json) => AddCodeModel(
      code: json['code'] as String?,
      validityDays: (json['validity_days'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddCodeModelToJson(AddCodeModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'validity_days': instance.validityDays,
    };
