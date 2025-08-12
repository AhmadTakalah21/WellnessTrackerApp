// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_plans_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPlansModel _$UserPlansModelFromJson(Map<String, dynamic> json) =>
    UserPlansModel(
      plans: (json['plans'] as List<dynamic>)
          .map((e) => UserPlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      psyPhone: json['psy_phone'] as String,
    );

Map<String, dynamic> _$UserPlansModelToJson(UserPlansModel instance) =>
    <String, dynamic>{
      'plans': instance.plans,
      'psy_phone': instance.psyPhone,
    };
