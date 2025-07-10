import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/global/models/adv_type_enum.dart';
import 'package:wellnesstrackerapp/global/utils/json_converters/bool_converter.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import '../../../../global/widgets/main_data_table.dart';

part 'adv_model.g.dart';

@JsonSerializable()
@immutable
class AdvModel implements DeleteModel, DataTableModel {
  const AdvModel({
    required this.id,
    required this.address,
    required this.description,
    required this.image,
    required this.expDate,
    required this.type,
    required this.isActive,
  });

  final int id;
  final String address;
  final String description;
  final String image;

  @JsonKey(name: 'exp_date')
  final String expDate;

  @JsonKey(fromJson: AdvTypeEnum.fromJson, toJson: AdvTypeEnum.toJson)
  final AdvTypeEnum type;

  @BoolConverter()
  @JsonKey(name: 'is_active')
  final bool isActive;

  static String get header => 'adv_management'.tr();

  static List<String> get titles => [
        '#',
        'address'.tr(),
        'description'.tr(),
        'image'.tr(),
        'exp_date'.tr(),
        'type'.tr(),
        'is_active'.tr(),
        'event'.tr(),
      ];

  @override
  List<String> get values => [
        '#$id',
        address,
        description,
        image,
        expDate,
        type.displayName,
        isActive ? 'active'.tr() : 'inactive'.tr(),
      ];

  factory AdvModel.fromString(String str) =>
      AdvModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory AdvModel.fromJson(Map<String, dynamic> json) =>
      _$AdvModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/adv/$id";
}
