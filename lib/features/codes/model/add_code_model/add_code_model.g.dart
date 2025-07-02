// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCodeModel _$AddCodeModelFromJson(Map<String, dynamic> json) => AddCodeModel(
      code: json['code'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      department:
          $enumDecodeNullable(_$DepartmentEnumEnumMap, json['department']),
    );

Map<String, dynamic> _$AddCodeModelToJson(AddCodeModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'department': DepartmentEnum.toJson(instance.department),
    };

const _$DepartmentEnumEnumMap = {
  DepartmentEnum.dietician: 'dietician',
  DepartmentEnum.coach: 'coach',
  DepartmentEnum.doctor: 'doctor',
};
