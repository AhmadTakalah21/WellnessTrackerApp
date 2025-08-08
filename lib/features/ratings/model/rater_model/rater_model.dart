import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'rater_model.g.dart';

@JsonSerializable()
@immutable
class RaterModel {
  const RaterModel({
    required this.id,
    required this.name,
    required this.email,
  });

  final int id;
  final String name;
  final String email;

  factory RaterModel.fromString(String str) =>
      RaterModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory RaterModel.fromJson(Map<String, dynamic> json) =>
      _$RaterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RaterModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
