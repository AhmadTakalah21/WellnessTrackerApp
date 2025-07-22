import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';

part 'notification_model.g.dart';

@JsonSerializable()
@immutable
class NotificationModel implements DeleteModel, DataTableModel {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  final int id;
  final String title;
  final String body;

  static String get header => 'notifications_management'.tr();

  static List<String> get titles => [
        '#',
        'title'.tr(),
        'body'.tr(),
        'event'.tr(),
      ];

  @override
  List<String> get values => [
        '#$id',
        title,
        body,
      ];

  factory NotificationModel.fromString(String str) =>
      NotificationModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/notification/$id";
}
