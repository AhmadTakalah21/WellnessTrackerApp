// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
class UserModel implements DeleteModel, DataTableModel, DropDownItemModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    this.subscribersCount = 0,
    this.fcmToken,
  });

  @override
  final int id;
  final String name;
  final String email;
  final String phone;

  @JsonKey(fromJson: UserRoleEnum.fromJson, toJson: UserRoleEnum.toJson)
  final UserRoleEnum role;
  final String status;

  @JsonKey(name: "sum")
  final int subscribersCount;

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
  String get apiDeleteUrl => "/v1/admin/users/$id";

  @override
  List<String> get values => [
        name,
        email,
        phone,
        role.displayName,
        subscribersCount.toString(),
        status,
      ];

  static String get header => "employees".tr();

  static List<String> get titles => [
        "name".tr(),
        "email".tr(),
        "phone".tr(),
        "role".tr(),
        "subscribers_count",
        "status".tr(),
        "event".tr(),
      ];

  @override
  String get displayName => name;

  @override
  String get displayEntityName => name;
}
