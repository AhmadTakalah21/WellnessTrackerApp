import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/activity_status_enum.dart';
import 'package:wellnesstrackerapp/global/models/en_ar_add_model/en_ar_add_model.dart';

part 'add_points_guideline_model.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class AddPointsGuidelineModel {
  const AddPointsGuidelineModel({
    EnArAddModel? title,
    this.description,
    this.isActive = ActivityStatusEnum.active,
  }) : _title = title;

  final EnArAddModel? _title;
  final EnArAddModel? description;

  @JsonKey(
    name: "is_active",
    fromJson: ActivityStatusEnum.fromJson,
    toJson: ActivityStatusEnum.toJson,
  )
  final ActivityStatusEnum isActive;

  AddPointsGuidelineModel copyWith({
    EnArAddModel? Function()? title,
    EnArAddModel? Function()? description,
    ActivityStatusEnum? isActive,
  }) {
    return AddPointsGuidelineModel(
      title: title != null ? title() : _title,
      description: description != null ? description() : this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  EnArAddModel get title {
    if (_title == null) {
      throw "title_required".tr();
    }
    return _title;
  }

  factory AddPointsGuidelineModel.fromJson(Map<String, dynamic> json) =>
      _$AddPointsGuidelineModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddPointsGuidelineModelToJson(this);

  factory AddPointsGuidelineModel.fromString(String jsonString) =>
      AddPointsGuidelineModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
