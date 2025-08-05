import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'update_settings_model.g.dart';

@JsonSerializable()
@immutable
class UpdateSettingsModel {
  const UpdateSettingsModel({
    String? name,
    String? appUrlAndroid,
    String? appUrlIos,
    String? email,
    String? supportPhoneNumber,
    String? psychologicalPhoneNumber,
  })  : _name = name,
        _appUrlAndroid = appUrlAndroid,
        _appUrlIos = appUrlIos,
        _email = email,
        _supportPhoneNumber = supportPhoneNumber,
        _psychologicalPhoneNumber = psychologicalPhoneNumber;

  final String? _name;
  final String? _appUrlAndroid;
  final String? _appUrlIos;
  final String? _email;
  final String? _supportPhoneNumber;
  final String? _psychologicalPhoneNumber;

  UpdateSettingsModel copyWith({
    String? Function()? name,
    String? Function()? appUrlAndroid,
    String? Function()? appUrlIos,
    String? Function()? email,
    String? Function()? supportPhoneNumber,
    String? Function()? psychologicalPhoneNumber,
  }) {
    return UpdateSettingsModel(
      name: name != null ? name() : _name,
      appUrlAndroid: appUrlAndroid != null ? appUrlAndroid() : _appUrlAndroid,
      appUrlIos: appUrlIos != null ? appUrlIos() : _appUrlIos,
      email: email != null ? email() : _email,
      supportPhoneNumber: supportPhoneNumber != null
          ? supportPhoneNumber()
          : _supportPhoneNumber,
      psychologicalPhoneNumber: psychologicalPhoneNumber != null
          ? psychologicalPhoneNumber()
          : _psychologicalPhoneNumber,
    );
  }

  String get name {
    if (_name == null || _name.isEmpty) {
      throw "name_required".tr();
    }
    return _name;
  }

  @JsonKey(name: 'app_url_android')
  String? get appUrlAndroid => _appUrlAndroid;

  @JsonKey(name: 'app_url_ios')
  String? get appUrlIos => _appUrlIos;

  String get email {
    if (_email == null || _email.isEmpty) {
      throw "email_required".tr();
    }
    return _email;
  }

  @JsonKey(name: 'support_phone_number')
  String get supportPhoneNumber {
    if (_supportPhoneNumber == null || _supportPhoneNumber.isEmpty) {
      throw "support_phone_required".tr();
    }
    return _supportPhoneNumber;
  }

  @JsonKey(name: 'psychological_support_number')
  String get psychologicalPhoneNumber {
    if (_psychologicalPhoneNumber == null || _psychologicalPhoneNumber.isEmpty) {
      throw "psychological_phone_required".tr();
    }
    return _psychologicalPhoneNumber;
  }

  factory UpdateSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSettingsModelToJson(this);

  factory UpdateSettingsModel.fromString(String jsonString) =>
      UpdateSettingsModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
