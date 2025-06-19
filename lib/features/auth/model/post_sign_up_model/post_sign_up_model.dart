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
    this.subscriptionCode,
  })  : _username = username,
        _email = email,
        _password = password;

  factory PostSignUpModel.fromJsonStr(String str) =>
      PostSignUpModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory PostSignUpModel.fromJson(Map<String, dynamic> json) =>
      _$PostSignUpModelFromJson(json);

  final String? _username;
  final String? _email;
  final String? _password;
  final String? confirmPassword;
  final String? subscriptionCode;

  Map<String, dynamic> toJson() => _$PostSignUpModelToJson(this);

  String? validateUsername() {
    if (_username == null || _username!.isEmpty) {
      return 'username_empty'.tr();
    }
    return null;
  }

  String? validateEmail() {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (_email == null || _email!.isEmpty) {
      return 'email_empty'.tr();
    }
    if (!emailRegex.hasMatch(_email!)) {
      return 'email_invalid'.tr();
    }
    return null;
  }

  String? validatePassword() {
    if (_password == null || _password!.isEmpty) {
      return 'password_empty'.tr();
    }
    if (_password!.length < 8) {
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

  String? validateSubscriptionCode() {
    if (subscriptionCode == null || subscriptionCode!.isEmpty) {
      return 'subscription_code_required'.tr();
    }
    return null;
  }

  PostSignUpModel copyWith({
    String? Function()? username,
    String? Function()? email,
    String? Function()? password,
    String? Function()? confirmPassword,
    String? Function()? subscriptionCode,
  }) {
    return PostSignUpModel(
      username: username != null ? username() : _username,
      email: email != null ? email() : _email,
      password: password != null ? password() : _password,
      confirmPassword: confirmPassword != null ? confirmPassword() : this.confirmPassword,
      subscriptionCode: subscriptionCode != null ? subscriptionCode() : this.subscriptionCode,
    );
  }

  String get username => _username ?? (throw 'username is required');
  String get email => _email ?? (throw 'email_empty'.tr());
  String get password => _password ?? (throw 'Password is required');
  String? get getEmail => _email;
}
