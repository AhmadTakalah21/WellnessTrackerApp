// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeModel _$CodeModelFromJson(Map<String, dynamic> json) => CodeModel(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      status: json['status'] as String,
      department:
          DepartmentModel.fromJson(json['department'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CodeModelToJson(CodeModel instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'status': instance.status,
      'department': instance.department,
    };
