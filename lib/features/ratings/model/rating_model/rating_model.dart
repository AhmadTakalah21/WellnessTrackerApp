import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wellnesstrackerapp/features/ratings/model/rater_model/rater_model.dart';

import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

part 'rating_model.g.dart';

@JsonSerializable()
@immutable
class RatingModel implements DeleteModel, DropDownItemModel {
  const RatingModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  @override
  final int id;

  final RaterModel user;
  final int rating;
  final String comment;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  factory RatingModel.fromString(String str) =>
      RatingModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/v1/admin/ratings/$id";

  @override
  String get displayName => '${user.name} - $rating';

  @override
  String get displayEntityName => '${user.name} ($rating)';
}
