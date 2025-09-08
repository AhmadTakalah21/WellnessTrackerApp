import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@JsonSerializable()
@immutable
class SettingsModel {
  const SettingsModel({
    required this.name,
    this.appUrlAndroid,
    this.appUrlIos,
    required this.email,
    required this.supportPhoneNumber,
    this.emergenciesPhone,
  });

  final String name;

  @JsonKey(name: 'app_url_android')
  final String? appUrlAndroid;

  @JsonKey(name: 'app_url_ios')
  final String? appUrlIos;

  final String email;

  @JsonKey(name: 'support_phone_number')
  final String supportPhoneNumber;

  @JsonKey(name: 'emergencies_phone')
  final String? emergenciesPhone;

  factory SettingsModel.fromString(String str) =>
      SettingsModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
