import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/adv_type_enum.dart';
import 'package:wellnesstrackerapp/global/models/en_ar_add_model/en_ar_add_model.dart';

part 'add_adv_model.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class AddAdvModel {
  const AddAdvModel({
    EnArAddModel? title,
    EnArAddModel? description,
    AdvTypeEnum? type,
    String? endDate,
  })  : _title = title,
        _description = description,
        _type = type,
        _endDate = endDate;

  final EnArAddModel? _title;
  final EnArAddModel? _description;
  final AdvTypeEnum? _type;
  final String? _endDate;

  AddAdvModel copyWith({
    EnArAddModel? Function()? title,
    EnArAddModel? Function()? description,
    AdvTypeEnum? Function()? type,
    String? Function()? endDate,
  }) {
    return AddAdvModel(
      title: title != null ? title() : _title,
      description: description != null ? description() : _description,
      type: type != null ? type() : _type,
      endDate: endDate != null ? endDate() : _endDate,
    );
  }

  EnArAddModel get title {
    if (_title == null) {
      throw "title_en_required".tr();
    }
    return _title;
  }

  EnArAddModel? get description => _description;

  @JsonKey(fromJson: AdvTypeEnum.fromJson, toJson: AdvTypeEnum.toJson)
  AdvTypeEnum get type {
    if (_type == null) {
      throw "type_required".tr();
    }
    return _type;
  }

  @JsonKey(name: 'end_date')
  String get endDate {
    if (_endDate == null || _endDate.isEmpty) {
      throw "end_date_required".tr();
    }
    return _endDate;
  }

  factory AddAdvModel.fromJson(Map<String, dynamic> json) =>
      _$AddAdvModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddAdvModelToJson(this);

  factory AddAdvModel.fromString(String jsonString) =>
      AddAdvModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
