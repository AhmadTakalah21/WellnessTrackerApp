import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'add_code_model.g.dart';

@JsonSerializable()
@immutable
class AddCodeModel {
  const AddCodeModel({
    String? code,
    int? validityDays,
  })  : _code = code,
        _validityDays = validityDays;

  final String? _code;
  final int? _validityDays;

  AddCodeModel copyWith({
    String? Function()? code,
    int? Function()? validityDays,
  }) {
    return AddCodeModel(
      code: code != null ? code() : _code,
      validityDays: validityDays != null ? validityDays() : _validityDays,
    );
  }

  String get code {
    if (_code == null || _code.isEmpty) {
      throw "code_required".tr();
    }
    return _code;
  }

  @JsonKey(name: "validity_days")
  int get validityDays {
    if (_validityDays == null) {
      throw "validity_days_required".tr();
    }
    return _validityDays;
  }

  factory AddCodeModel.fromJson(Map<String, dynamic> json) =>
      _$AddCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCodeModelToJson(this);

  factory AddCodeModel.fromString(String jsonString) =>
      AddCodeModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
