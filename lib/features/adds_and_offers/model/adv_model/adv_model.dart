import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/global/models/adv_type_enum.dart';
import 'package:wellnesstrackerapp/global/models/en_ar_model/en_ar_model.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';

part 'adv_model.g.dart';

@JsonSerializable()
@immutable
class AdvModel implements DeleteModel, DataTableModel {
  const AdvModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.image,
    required this.startDate,
    required this.endDate,
  });

  final int id;
  final EnArModel title;
  final EnArModel description;

  @JsonKey(fromJson: AdvTypeEnum.fromJson, toJson: AdvTypeEnum.toJson)
  final AdvTypeEnum type;

  @JsonKey(name: "image_path")
  final String image;

  @JsonKey(name: 'start_date')
  final String startDate;

  @JsonKey(name: 'end_date')
  final String endDate;

  static String get header => 'adv_management'.tr();

  static List<String> get titles => [
        '#',
        'title'.tr(),
        'description'.tr(),
        'type'.tr(),
        'image'.tr(),
        'start_date'.tr(),
        'end_date'.tr(),
        'event'.tr(),
      ];

  @override
  List<String> get values => [
        '#$id',
        title.en,
        description.en,
        type.displayName,
        image,
        startDate,
        endDate,
      ];

  factory AdvModel.fromString(String str) =>
      AdvModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory AdvModel.fromJson(Map<String, dynamic> json) =>
      _$AdvModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "v1/admin/advertisements/$id";
}
