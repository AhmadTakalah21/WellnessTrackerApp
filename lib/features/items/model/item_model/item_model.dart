import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';

part 'item_model.g.dart';

@JsonSerializable()
@immutable
class ItemModel implements DeleteModel {
  const ItemModel({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.link,
    required this.level,
    this.image,
  });

  final int id;
  final String name;
  final double price;
  final String? description;
  final String? link;
  final LevelModel level;

  @JsonKey(name: "image_path")
  final String? image;

  factory ItemModel.fromString(String str) =>
      ItemModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() => jsonEncode(toJson());

  @override
  String get apiDeleteUrl => "/v1/admin/items/$id";
}
