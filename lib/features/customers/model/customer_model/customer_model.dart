import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/features/customers/model/customer_info_model/customer_info_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_subscription_model/customer_subscription_model.dart';
import 'package:wellnesstrackerapp/global/models/gender_enum.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

part 'customer_model.g.dart';

@JsonSerializable()
@immutable
class CustomerModel implements DeleteModel, DataTableModel, DropDownItemModel {
  const CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.gender,
    this.birthday,
    required this.status,
    required this.role,
    this.info,
    this.subscription,
    required this.createdAt,
  });

  @override
  final int id;
  final String name;
  final String email;
  final String? phone;

  @JsonKey(
    fromJson: GenderEnum.nullableFromJson,
    toJson: GenderEnum.nullableToJson,
  )
  final GenderEnum? gender;

  final String? birthday;
  final String status;

  @JsonKey(fromJson: UserRoleEnum.fromJson, toJson: UserRoleEnum.toJson)
  final UserRoleEnum role;

  @JsonKey(name: "information")
  final CustomerInfoModel? info;

  final CustomerSubscriptionModel? subscription;

  @JsonKey(name: 'created_at')
  final String createdAt;

  static String get header => 'customers_administration'.tr();

  static List<String> get titles => [
        '#',
        'name'.tr(),
        'email'.tr(),
        'phone'.tr(),
        'dietitian'.tr(),
        'coach'.tr(),
        'doctor'.tr(),
        'status'.tr(),
        'event'.tr(),
      ];

  @override
  List<String> get values => [
        '#$id',
        name,
        email,
        phone ?? '_',
        subscription?.dietitian?.name ?? 'not_existed'.tr(),
        subscription?.coach?.name ?? 'not_existed'.tr(),
        subscription?.doctor?.name ?? 'not_existed'.tr(),
        status,
      ];

  factory CustomerModel.fromString(String str) =>
      CustomerModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/v1/admin/users/$id";

  @override
  String get displayName => name;

  @override
  String get displayEntityName => name;
}
