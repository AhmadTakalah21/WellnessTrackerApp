// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerSubscriptionModel _$CustomerSubscriptionModelFromJson(
        Map<String, dynamic> json) =>
    CustomerSubscriptionModel(
      id: (json['id'] as num).toInt(),
      status: (json['status'] as num).toInt(),
      dietitian: json['dietitian'] == null
          ? null
          : UserModel.fromJson(json['dietitian'] as Map<String, dynamic>),
      coach: json['coach'] == null
          ? null
          : UserModel.fromJson(json['coach'] as Map<String, dynamic>),
      doctor: json['doctor'] == null
          ? null
          : UserModel.fromJson(json['doctor'] as Map<String, dynamic>),
      psychologist: json['psychologist'] == null
          ? null
          : UserModel.fromJson(json['psychologist'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerSubscriptionModelToJson(
        CustomerSubscriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'dietitian': instance.dietitian,
      'coach': instance.coach,
      'doctor': instance.doctor,
      'psychologist': instance.psychologist,
    };
