import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';

part 'code_model.g.dart';

@JsonSerializable()
@immutable
class CodeModel implements DeleteModel, DataTableModel {
  const CodeModel({
    required this.id,
    required this.code,
    required this.validityDays,
    required this.status,
  });

  @override
  final int id;
  final String code;

  @JsonKey(name: "validity_days")
  final int validityDays;

  final String status;

  static String get header => 'codes_management'.tr();

  static List<String> get titles => [
        '#',
        'code'.tr(),
        'validity_days'.tr(),
        'status'.tr(),
        'event'.tr(),
      ];

  @override
  List<String> get values => [
        '#$id',
        code,
        "${validityDays.toString()} ${"days".tr()}",
        status,
      ];

  factory CodeModel.fromString(String str) =>
      CodeModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory CodeModel.fromJson(Map<String, dynamic> json) =>
      _$CodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CodeModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/v1/admin/codes/$id";
}
