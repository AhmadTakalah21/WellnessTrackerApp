// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_subscribers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignSubscribersModel _$AssignSubscribersModelFromJson(
        Map<String, dynamic> json) =>
    AssignSubscribersModel(
      users: (json['user_id'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      dietitianId: (json['dietitian_id'] as num?)?.toInt(),
      coachId: (json['coach_id'] as num?)?.toInt(),
      levelId: (json['level_id'] as num?)?.toInt(),
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      psychologistId: (json['psychologist_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AssignSubscribersModelToJson(
        AssignSubscribersModel instance) =>
    <String, dynamic>{
      'user_id': instance.users,
      'dietitian_id': instance.dietitianId,
      'coach_id': instance.coachId,
      'level_id': instance.levelId,
      'doctor_id': instance.doctorId,
      'psychologist_id': instance.psychologistId,
    };
