import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'add_rate_model.g.dart';

@JsonSerializable()
@immutable
class AddRateModel {
  const AddRateModel({
    this.rating = 2,
    String? comment,
  }) : _comment = comment;

  final int? rating;
  final String? _comment;

  AddRateModel copyWith({
    int? Function()? rating,
    String? Function()? comment,
  }) {
    return AddRateModel(
      rating: rating != null ? rating() : this.rating,
      comment: comment != null ? comment() : _comment,
    );
  }

  String get comment {
    if (_comment == null || _comment.isEmpty) {
      throw "note_required".tr();
    }
    return _comment;
  }

  factory AddRateModel.fromJson(Map<String, dynamic> json) =>
      _$AddRateModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddRateModelToJson(this);

  factory AddRateModel.fromString(String jsonString) =>
      AddRateModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
