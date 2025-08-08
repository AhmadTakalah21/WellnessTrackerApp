// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeModel _$CodeModelFromJson(Map<String, dynamic> json) => CodeModel(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      validityDays: (json['validity_days'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$CodeModelToJson(CodeModel instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'validity_days': instance.validityDays,
      'status': instance.status,
    };
