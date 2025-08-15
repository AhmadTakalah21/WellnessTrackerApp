import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'customer_info_model.g.dart';

@immutable
@JsonSerializable()
class CustomerInfoModel {
  const CustomerInfoModel({
    required this.id,
     this.age,
    required this.weight,
    required this.length,
    this.chronicDiseases,
    this.waistCircumference,
    this.chest,
    this.shoulder,
    this.thighCircumference,
    required this.forearmCircumference,
    required this.createdAt,
  });

  final int id;
  final int? age;
  final int weight;
  final int length;

  @JsonKey(name: 'chronic_diseases')
  final String? chronicDiseases;

  @JsonKey(name: 'waist_circumference')
  final int? waistCircumference;

  final int? chest;
  final int? shoulder;

  @JsonKey(name: 'thigh_circumference')
  final int? thighCircumference;

  @JsonKey(name: 'forearm_circumference')
  final int? forearmCircumference;

  @JsonKey(name: 'created_at')
  final String createdAt;

  factory CustomerInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerInfoModelToJson(this);

  factory CustomerInfoModel.fromString(String source) =>
      CustomerInfoModel.fromJson(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() => jsonEncode(toJson());
}
