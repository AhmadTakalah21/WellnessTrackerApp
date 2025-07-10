// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_subscriber_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignSubscriberModel _$AssignSubscriberModelFromJson(
        Map<String, dynamic> json) =>
    AssignSubscriberModel(
      userId: (json['user_id'] as num?)?.toInt(),
      dietitianId: (json['dietitian_id'] as num?)?.toInt(),
      coachId: (json['coach_id'] as num?)?.toInt(),
      levelId: (json['level_id'] as num?)?.toInt(),
      doctorId: (json['doctor_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AssignSubscriberModelToJson(
        AssignSubscriberModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'dietitian_id': instance.dietitianId,
      'coach_id': instance.coachId,
      'level_id': instance.levelId,
      'doctor_id': instance.doctorId,
    };
