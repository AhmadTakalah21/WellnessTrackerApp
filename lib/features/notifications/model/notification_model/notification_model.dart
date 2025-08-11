import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/global/utils/json_converters/bool_converter.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';

part 'notification_model.g.dart';

@JsonSerializable()
@immutable
class NotificationModel implements DeleteModel {
  const NotificationModel({
    required this.id,
    required this.title,
    this.data,
    this.senderId,
    this.receiverId,
    this.sendAt,
    required this.isSent,
    required this.createdAt,
    required this.updatedAt,
    required this.message,
  });

  final int id;
  final String title;

  final dynamic data; // nullable, can be any type from API
  @JsonKey(name: 'sender_id')
  final int? senderId;
  @JsonKey(name: 'receiver_id')
  final int? receiverId;
  @JsonKey(name: 'send_at')
  final String? sendAt;

  @BoolConverter()
  @JsonKey(name: 'is_sent')
  final bool isSent;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  final String message;


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
