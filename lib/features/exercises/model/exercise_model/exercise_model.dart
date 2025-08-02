// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_description_model/exercise_description_model.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

part 'exercise_model.g.dart';

@JsonSerializable()
@immutable
class ExerciseModel implements DeleteModel, DataTableModel, DropDownItemModel {
  const ExerciseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.link,
    required this.coach,
    required this.createdAt,
  });

  @override
  final int id;
  final String name;
  final ExerciseDescriptionModel description;
  final String link;
  final CustomerModel coach;

  @JsonKey(name: 'created_at')
  final String createdAt;

  static String get header => 'exercise_management'.tr();

  static List<String> get titles => [
        '#',
        'name'.tr(),
        'link'.tr(),
        'coach'.tr(),
        'created_at'.tr(),
        'event'.tr(),
      ];

  @override
  List<String> get values => [
        '#$id',
        name,
        link,
        coach.name,
        createdAt,
      ];

  factory ExerciseModel.fromString(String str) =>
      ExerciseModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/v1/coach/exercises/$id";

  @override
  String get displayEntityName => name;

  @override
  String get displayName => name;
}
