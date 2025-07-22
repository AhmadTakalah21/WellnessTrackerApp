import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'add_points_model.g.dart';

@JsonSerializable()
@immutable
class AddPointsModel {
  const AddPointsModel({
    List<int>? subscribers =const [],
    String? points,
  })  : _subscribers = subscribers,
        _points = points;

  final List<int>? _subscribers;
  final String? _points;

  AddPointsModel copyWith({
    List<int>? Function()? subscribers,
    String? Function()? points,
  }) {
    return AddPointsModel(
      subscribers: subscribers != null ? subscribers() : _subscribers,
      points: points != null ? points() : _points,
    );
  }

  List<int> get subscribers {
    if (_subscribers == null || _subscribers.isEmpty) {
      throw "at_least_one_subscriber".tr();
    }
    return _subscribers;
  }

  String get points {
    if (_points == null) {
      throw "points_required".tr();
    }
    return _points;
  }

  factory AddPointsModel.fromJson(Map<String, dynamic> json) =>
      _$AddPointsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddPointsModelToJson(this);

  factory AddPointsModel.fromString(String jsonString) =>
      AddPointsModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
