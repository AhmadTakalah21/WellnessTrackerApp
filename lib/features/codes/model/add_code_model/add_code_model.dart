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
    String? startDate,
    String? endDate,
  })  : _code = code,
        _startDate = startDate,
        _endDate = endDate;

  final String? _code;
  final String? _startDate;
  final String? _endDate;

  AddCodeModel copyWith({
    String? Function()? code,
    String? Function()? startDate,
    String? Function()? endDate,
  }) {
    return AddCodeModel(
      code: code != null ? code() : _code,
      startDate: startDate != null ? startDate() : _startDate,
      endDate: endDate != null ? endDate() : _endDate,
    );
  }

  String get code {
    if (_code == null || _code.isEmpty) {
      throw "code_required".tr();
    }
    return _code;
  }

  @JsonKey(name: "start_date")
  String get startDate {
    if (_startDate == null || _startDate.isEmpty) {
      throw "start_date_required".tr();
    }
    return _startDate;
  }

  @JsonKey(name: "end_date")
  String get endDate {
    if (_endDate == null || _endDate.isEmpty) {
      throw "end_date_required".tr();
    }
    return _endDate;
  }

  factory AddCodeModel.fromJson(Map<String, dynamic> json) =>
      _$AddCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCodeModelToJson(this);

  factory AddCodeModel.fromString(String jsonString) =>
      AddCodeModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
