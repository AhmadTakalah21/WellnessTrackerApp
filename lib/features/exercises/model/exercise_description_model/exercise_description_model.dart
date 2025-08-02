import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/global/utils/json_converters/int_converter.dart';

part 'exercise_description_model.g.dart';

@JsonSerializable()
@immutable
class ExerciseDescriptionModel {
  const ExerciseDescriptionModel({
    required this.rounds,
    required this.explain,
    this.repeats = const [],
  });

  @IntConverter()
  final int rounds;
  final String explain;
  final List<int> repeats;

  factory ExerciseDescriptionModel.fromString(String str) =>
      ExerciseDescriptionModel.fromJson(
          jsonDecode(str) as Map<String, dynamic>);

  factory ExerciseDescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseDescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseDescriptionModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
