import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'en_ar_model.g.dart';

@JsonSerializable()
@immutable
class EnArModel {
  const EnArModel({this.en, this.ar});

  final String? en;
  final String? ar;

  Map<String, dynamic> toJson() => _$EnArModelToJson(this);

  factory EnArModel.fromJson(Map<String, dynamic> json) =>
      _$EnArModelFromJson(json);

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  factory EnArModel.fromString(String jsonString) {
    return EnArModel.fromJson(json.decode(jsonString));
  }
}
