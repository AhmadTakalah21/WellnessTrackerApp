import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'update_profile_model.g.dart';

@JsonSerializable()
@immutable
class UpdateProfileModel {
  const UpdateProfileModel({String? name, String? phone})
      : _name = name,
        _phone = phone;

  final String? _name;
  final String? _phone;

  UpdateProfileModel copyWith({
    String? Function()? name,
    String? Function()? phone,
  }) {
    return UpdateProfileModel(
      name: name != null ? name() : _name,
      phone: phone != null ? phone() : _phone,
    );
  }

  String get name {
    if (_name == null || _name.isEmpty) {
      throw "name_required".tr();
    }
    return _name;
  }

  @JsonKey(name: "phone")
  String get phone {
    if (_phone == null) {
      throw "phone_required".tr();
    }
    return _phone;
  }

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileModelToJson(this);

  factory UpdateProfileModel.fromString(String jsonString) =>
      UpdateProfileModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
