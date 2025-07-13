import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'en_ar_add_model.g.dart';

@JsonSerializable()
@immutable
class EnArAddModel {
  const EnArAddModel({
    String? en,
    String? ar,
  })  : _en = en,
        _ar = ar;

  final String? _en;
  final String? _ar;

  EnArAddModel copyWith({
    String? Function()? en,
    String? Function()? ar,
  }) {
    return EnArAddModel(
      en: en != null ? en() : _en,
      ar: ar != null ? ar() : _ar,
    );
  }

  String get en {
    if (_en == null || _en.isEmpty) {
      throw "english_value_required".tr();
    }
    return _en;
  }

  String get ar {
    if (_ar == null || _ar.isEmpty) {
      throw "arabic_value_required".tr();
    }
    return _ar;
  }

  factory EnArAddModel.fromJson(Map<String, dynamic> json) =>
      _$EnArAddModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnArAddModelToJson(this);

  factory EnArAddModel.fromString(String jsonString) =>
      EnArAddModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
