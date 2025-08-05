// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) =>
    SettingsModel(
      name: json['name'] as String,
      appUrlAndroid: json['app_url_android'] as String?,
      appUrlIos: json['app_url_ios'] as String?,
      email: json['email'] as String,
      supportPhoneNumber: json['support_phone_number'] as String,
      psychologicalPhoneNumber: json['psychological_support_number'] as String?,
    );

Map<String, dynamic> _$SettingsModelToJson(SettingsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'app_url_android': instance.appUrlAndroid,
      'app_url_ios': instance.appUrlIos,
      'email': instance.email,
      'support_phone_number': instance.supportPhoneNumber,
      'psychological_support_number': instance.psychologicalPhoneNumber,
    };
