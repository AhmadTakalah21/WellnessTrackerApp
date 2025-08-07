import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';

part 'customer_subscription_model.g.dart';

@JsonSerializable()
@immutable
class CustomerSubscriptionModel {
  const CustomerSubscriptionModel({
    required this.id,
    required this.status,
    this.dietitian,
    this.coach,
    this.doctor,
  });

  final int id;
  final int status;
  final UserModel? dietitian;
  final UserModel? coach;
  final UserModel? doctor;

  factory CustomerSubscriptionModel.fromString(String str) =>
      CustomerSubscriptionModel.fromJson(
          jsonDecode(str) as Map<String, dynamic>);

  factory CustomerSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerSubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerSubscriptionModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
