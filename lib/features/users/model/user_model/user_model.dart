import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/global/utils/json_converters/bool_converter.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
class UserModel implements DeleteModel, DataTableModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.isActive,
    this.fcmToken,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String role;

  @BoolConverter()
  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'fcm_token')
  final String? fcmToken;

  factory UserModel.fromString(String str) =>
      UserModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/user/$id";

  @override
  List<String> get values => [
    name,
    email,
    phone,
    role,
    isActive ? "active".tr() : "inactive".tr(),
  ];

  static String get header => "employees".tr();

  static List<String> get titles => [
    "name".tr(),
    "email".tr(),
    "phone".tr(),
    "role".tr(),
    "status".tr(),
    "event".tr(),
  ];
}
