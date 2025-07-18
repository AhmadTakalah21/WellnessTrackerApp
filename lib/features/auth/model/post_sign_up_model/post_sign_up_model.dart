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
    String? phoneNumber,
    String? password,
    this.confirmPassword,
    this.fcmToken,
    String? code,
  })  : _username = username,
        _email = email,
        _phoneNumber = phoneNumber,
        _password = password,
        _code = code;

  factory PostSignUpModel.fromJsonStr(String str) =>
      PostSignUpModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory PostSignUpModel.fromJson(Map<String, dynamic> json) =>
      _$PostSignUpModelFromJson(json);

  final String? _username;
  final String? _email;
  final String? _phoneNumber;
  final String? _password;
  @JsonKey(name: 'fcm_token')
  final String? fcmToken;

  @JsonKey(name: "password_confirmation")
  final String? confirmPassword;

  final String? _code;

  Map<String, dynamic> toJson() => _$PostSignUpModelToJson(this);

  String? validateUsername() {
    if (_username == null || _username.isEmpty) {
      return 'username_empty'.tr();
    }
    return null;
  }

  String? validateEmail() {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (_email == null || _email.isEmpty) {
      return 'email_empty'.tr();
    }
    if (!emailRegex.hasMatch(_email)) {
      return 'email_invalid'.tr();
    }
    return null;
  }

  String? validatePhoneNumber() {
    if (_phoneNumber == null || _phoneNumber.isEmpty) {
      return null;
    }

    if (_phoneNumber.length != 10) {
      return 'phone_number_10_digits'.tr();
    }

    if (!_phoneNumber.startsWith('09')) {
      return 'phone_number_start_09'.tr();
    }

    return null;
  }

  String? validatePassword() {
    if (_password == null || _password.isEmpty) {
      return 'password_empty'.tr();
    }
    if (_password.length < 8) {
      return 'password_8_chars'.tr();
    }
    return null;
  }

  String? validateConfirmPassword() {
    if (confirmPassword == null || confirmPassword!.isEmpty) {
      return 'confirm_password_empty'.tr();
    }
    if (_password != confirmPassword) {
      return 'password_not_match'.tr();
    }
    return null;
  }

  String? validateCode() {
    if (_code == null || _code.isEmpty) {
      return 'code_required'.tr();
    }
    return null;
  }

  PostSignUpModel copyWith({
    String? Function()? username,
    String? Function()? email,
    String? Function()? phoneNumber,
    String? Function()? password,
    String? Function()? confirmPassword,
    String? Function()? code,
    String? Function()? fcmToken,
  }) {
    return PostSignUpModel(
      username: username != null ? username() : _username,
      email: email != null ? email() : _email,
      phoneNumber: phoneNumber != null ? phoneNumber() : _phoneNumber,
      password: password != null ? password() : _password,
      confirmPassword:
          confirmPassword != null ? confirmPassword() : this.confirmPassword,
      code: code != null ? code() : _code,
      fcmToken: fcmToken != null ? fcmToken() : this.fcmToken,
    );
  }

  @JsonKey(name: "name")
  String get username => _username ?? (throw 'username_required'.tr());

  String get email => _email ?? (throw 'email_empty'.tr());

  @JsonKey(name: "phone")
  String? get phoneNumber => _phoneNumber;

  String get password => _password ?? (throw 'password_required'.tr());
  String get code => _code ?? (throw 'code_required'.tr());
  String? get getEmail => _email;
}
