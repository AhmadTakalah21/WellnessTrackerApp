import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/features/customers/model/customer_info_model/customer_info_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_subscription_model/customer_subscription_model.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/models/gender_enum.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/utils/json_utils.dart';
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
    this.age,
    required this.email,
    this.phone,
    this.gender,
    this.birthday,
    required this.status,
    this.image,
    required this.role,
    this.info,
    this.subscription,
    this.level,
    this.code,
    this.subEndDate,
    this.isAdmin = false,
    this.isForEmployee = false,
    this.totalPoints,
    this.medicalConsultationsNum,
    required this.createdAt,
  });

  @override
  final int id;
  final String name;
  final int? age;
  final String email;
  final String? phone;

  @JsonKey(
    fromJson: GenderEnum.nullableFromJson,
    toJson: GenderEnum.nullableToJson,
  )
  final GenderEnum? gender;

  final String? birthday;
  final String status;

  @JsonKey(
    fromJson: JsonUtils.setImageUrlNullableFromJson,
    readValue: JsonUtils.readValue,
  )
  final String? image;

  @JsonKey(fromJson: UserRoleEnum.fromJson, toJson: UserRoleEnum.toJson)
  final UserRoleEnum role;

  @JsonKey(name: "information")
  final CustomerInfoModel? info;

  final CustomerSubscriptionModel? subscription;

  final LevelModel? level;

  @JsonKey(name: "code")
  final String? code;

  @JsonKey(name: "subscription_end_date")
  final String? subEndDate;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isAdmin;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isForEmployee;

  @JsonKey(name: "total_points")
  final int? totalPoints;

  @JsonKey(name: "medical_consultations_num")
  final int? medicalConsultationsNum;

  @JsonKey(name: 'created_at')
  final String createdAt;

  static String get header => 'customers_administration'.tr();

  @override
  List<String> get values => [
        '#$id',
        name,
        email,
        phone ?? '_',
        if (isAdmin && !isForEmployee) ...[
          subscription?.dietitian?.name ?? 'not_existed'.tr(),
          subscription?.coach?.name ?? 'not_existed'.tr(),
          subscription?.doctor?.name ?? 'not_existed'.tr(),
          subscription?.psychologist?.name ?? 'not_existed'.tr(),
        ],
        if (isAdmin) ...[
          code ?? 'not_existed'.tr(),
          subEndDate ?? 'not_existed'.tr(),
        ],
        if (isForEmployee)
          if (medicalConsultationsNum != null &&
              (role.isDoctor || role.isPsychologist))
            medicalConsultationsNum!.toString(),
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

  CustomerModel copyWith({
    bool? isAdmin,
    bool? isForEmployee,
  }) {
    return CustomerModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      gender: gender,
      birthday: birthday,
      status: status,
      role: role,
      info: info,
      subscription: subscription,
      level: level,
      isAdmin: isAdmin ?? this.isAdmin,
      isForEmployee: isForEmployee ?? this.isForEmployee,
      code: code,
      medicalConsultationsNum: medicalConsultationsNum,
      subEndDate: subEndDate,
      totalPoints: totalPoints,
      createdAt: createdAt,
    );
  }
}
