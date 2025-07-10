import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/adv_type_enum.dart';

part 'add_adv_model.g.dart';

@JsonSerializable()
@immutable
class AddAdvModel {
  const AddAdvModel({
    String? titleEn,
    String? titleAr,
    String? descriptionEn,
    String? descriptionAr,
    AdvTypeEnum? type,
    String? endDate,
  })  : _titleEn = titleEn,
        _titleAr = titleAr,
        _descriptionEn = descriptionEn,
        _descriptionAr = descriptionAr,
        _type = type,
        _endDate = endDate;

  final String? _titleEn;
  final String? _titleAr;
  final String? _descriptionEn;
  final String? _descriptionAr;
  final AdvTypeEnum? _type;
  final String? _endDate;

  AddAdvModel copyWith({
    String? Function()? titleEn,
    String? Function()? titleAr,
    String? Function()? descriptionEn,
    String? Function()? descriptionAr,
    AdvTypeEnum? Function()? type,
    String? Function()? endDate,
  }) {
    return AddAdvModel(
      titleEn: titleEn != null ? titleEn() : _titleEn,
      titleAr: titleAr != null ? titleAr() : _titleAr,
      descriptionEn: descriptionEn != null ? descriptionEn() : _descriptionEn,
      descriptionAr: descriptionAr != null ? descriptionAr() : _descriptionAr,
      type: type != null ? type() : _type,
      endDate: endDate != null ? endDate() : _endDate,
    );
  }

  @JsonKey(name: 'title[en]')
  String get titleEn {
    if (_titleEn == null || _titleEn.isEmpty) {
      throw "title_en_required".tr();
    }
    return _titleEn;
  }

  @JsonKey(name: 'title[ar]')
  String get titleAr {
    if (_titleAr == null || _titleAr.isEmpty) {
      throw "title_ar_required".tr();
    }
    return _titleAr;
  }

  @JsonKey(name: 'description[en]')
  String? get descriptionEn => _descriptionEn;

  @JsonKey(name: 'description[ar]')
  String? get descriptionAr => _descriptionAr;

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
