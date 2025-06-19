// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'sign_in_model.g.dart';

@JsonSerializable()
@immutable
class SignInModel {
  const SignInModel({
    required this.id,
    required this.email,
    required this.token,
    required this.name,
    required this.phone,
    required this.role,
  });

  final int id;
  final String email;
  final String token;
  final String name;
  final String phone;

  @JsonKey(fromJson: UserRoleEnum.fromJson , toJson: UserRoleEnum.toJson)
  final UserRoleEnum role;

  factory SignInModel.fromString(String str) =>
      SignInModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);

  @override
  String toString() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => _$SignInModelToJson(this);
}
