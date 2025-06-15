import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'reset_password_post_model.g.dart';

@JsonSerializable()
@immutable
class ResetPasswordPostModel {
  const ResetPasswordPostModel({String? password, this.confirmPassword})
    : _password = password;

  factory ResetPasswordPostModel.fromJsonStr(String str) =>
      ResetPasswordPostModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory ResetPasswordPostModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordPostModelFromJson(json);

  final String? _password;
  final String? confirmPassword;

  Map<String, dynamic> toJson() => _$ResetPasswordPostModelToJson(this);

  String? validatePassword() {
    if (_password == null || _password.isEmpty) {
      return 'password_empty'.tr();
    }

    final length = _password.length;
    if (length < 8) {
      return 'password_8_chars'.tr();
    }

    return null;
  }

  String? validateConfirmPassword() {
    final password = _password;

    if (confirmPassword == null || confirmPassword?.isEmpty == true) {
      return 'confirm_password_empty'.tr();
    }

    if (password == null || password.isEmpty == true) {
      return null;
    }

    if (password != confirmPassword) {
      return 'password_not_match'.tr();
    }

    return null;
  }

  ResetPasswordPostModel copyWith({
    String? Function()? password,
    String? Function()? confirmPassword,
  }) {
    return ResetPasswordPostModel(
      password: password != null ? password() : _password,
      confirmPassword:
          confirmPassword != null ? confirmPassword() : this.confirmPassword,
    );
  }

  String get password {
    return _password ?? (throw 'Password is required');
  }
}
