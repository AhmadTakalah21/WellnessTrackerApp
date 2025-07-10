import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';

part 'level_model.g.dart';

@JsonSerializable()
@immutable
class LevelModel implements DeleteModel, DataTableModel {
  const LevelModel({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.type,
  });

  final int id;
  final String image;
  final String title;
  final String description;

  @JsonKey(
    fromJson: DepartmentEnum.getDepartmentById,
    toJson: DepartmentEnum.toJson,
  )
  final DepartmentEnum type;

  static String get header => 'levels'.tr();

  static List<String> get titles => [
        '#',
        'title'.tr(),
        'description'.tr(),
        'department'.tr(),
        'event'.tr(),
      ];

  @override
  List<String> get values => [
        '#$id',
        title,
        description,
        type.displayEntityName,
      ];

  factory LevelModel.fromString(String str) =>
      LevelModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/v1/admin/levels/$id";
}
