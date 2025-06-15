import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'post_sign_up_model.g.dart';

@JsonSerializable()
@immutable
class PostSignUpModel {
  const PostSignUpModel({
    String? username,
    String? email,
    String? password,
    this.confirmPassword,
  }) : _username = username,
       _password = password,
       _email = email;

  factory PostSignUpModel.fromJsonStr(String str) =>
      PostSignUpModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory PostSignUpModel.fromJson(Map<String, dynamic> json) =>
      _$PostSignUpModelFromJson(json);

  final String? _username;
  final String? _email;
  final String? _password;
  final String? confirmPassword;

  Map<String, dynamic> toJson() => _$PostSignUpModelToJson(this);

  String? validateUsername() {
    if (_username == null || _username.isEmpty) {
      return 'username_empty'.tr();
    }
    return null;
  }

  String? validateEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (_email == null || _email.isEmpty) {
      return 'email_empty'.tr();
    }

    if (!emailRegex.hasMatch(_email)) {
      return "email_invalid".tr();
    }

    return null;
  }

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

  PostSignUpModel copyWith({
    String? Function()? username,
    String? Function()? email,
    String? Function()? password,
    String? Function()? confirmPassword,
  }) {
    return PostSignUpModel(
      username: username != null ? username() : _username,
      email: email != null ? email() : _email,
      password: password != null ? password() : _password,
      confirmPassword:
          confirmPassword != null ? confirmPassword() : this.confirmPassword,
    );
  }

  String get username {
    return _username ?? (throw 'username is required');
  }

  String get email {
    return _email ?? (throw 'email_empty'.tr());
  }

  String? get getEmail => _email;

  String get password {
    return _password ?? (throw 'Password is required');
  }
}
