import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'stats_model.g.dart';

@JsonSerializable()
@immutable
class StatsModel {
  const StatsModel({
    required this.activeUsers,
    required this.dietitianUsers,
    required this.exerciseUsers,
    required this.maleUsers,
    required this.femaleUsers,
    required this.avgAgesUsers,
    required this.avgWeightsUsers,
    required this.avgLengthsUsers,
  });

  @JsonKey(name: "active_users")
  final int activeUsers;

  @JsonKey(name: "dietitian_users")
  final int dietitianUsers;

  @JsonKey(name: "exercise_users")
  final int exerciseUsers;

  @JsonKey(name: "male_users")
  final int maleUsers;

  @JsonKey(name: "female_users")
  final int femaleUsers;

  @JsonKey(name: "avg_ages_users")
  final double avgAgesUsers;

  @JsonKey(name: "avg_weights_users")
  final double avgWeightsUsers;

  @JsonKey(name: "avg_lengths_users")
  final double avgLengthsUsers;


  factory StatsModel.fromString(String str) =>
      StatsModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory StatsModel.fromJson(Map<String, dynamic> json) =>
      _$StatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatsModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
