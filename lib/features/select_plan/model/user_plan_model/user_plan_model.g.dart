// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPlanModel _$UserPlanModelFromJson(Map<String, dynamic> json) =>
    UserPlanModel(
      department: DepartmentEnum.fromJson((json['department'] as num).toInt()),
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$UserPlanModelToJson(UserPlanModel instance) =>
    <String, dynamic>{
      'department': DepartmentEnum.toJson(instance.department),
      'phone': instance.phone,
    };
