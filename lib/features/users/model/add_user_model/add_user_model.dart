import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';

part 'add_user_model.g.dart';

@JsonSerializable()
@immutable
class AddUserModel {
  const AddUserModel({
    String? name,
    String? email,
    String? password,
    String? phone,
    DepartmentEnum? role,
    //bool? isActive,
  })  : _name = name,
        _email = email,
        _password = password,
        _phone = phone,
        _role = role;
  // _isActive = isActive;

  final String? _name;
  final String? _email;
  final String? _password;
  final String? _phone;
  final DepartmentEnum? _role;

  // @JsonKey(name: 'is_active')
  // final bool? _isActive;

  AddUserModel copyWith({
    String? Function()? name,
    String? Function()? email,
    String? Function()? password,
    String? Function()? phone,
    DepartmentEnum? Function()? role,
    //bool? Function()? isActive,
  }) {
    return AddUserModel(
      name: name != null ? name() : _name,
      email: email != null ? email() : _email,
      password: password != null ? password() : _password,
      phone: phone != null ? phone() : _phone,
      role: role != null ? role() : _role,
      // isActive: isActive != null ? isActive() : _isActive,
    );
  }

  String get name {
    if (_name == null || _name.isEmpty) {
      throw "name_required".tr();
    }
    return _name;
  }

  String get email {
    if (_email == null || _email.isEmpty) {
      throw "email_empty".tr();
    }
    return _email;
  }

  String get password {
    if (_password == null || _password.isEmpty) {
      throw "password_empty".tr();
    }
    return _password;
  }

  String get phone {
    if (_phone == null || _phone.isEmpty) {
      throw "phone_required".tr();
    }
    return _phone;
  }

  @JsonKey(fromJson: DepartmentEnum.fromJson2, toJson: DepartmentEnum.toJson2)
  DepartmentEnum get role {
    if (_role == null) {
      throw "role_required".tr();
    }
    return _role;
  }

  //bool get isActive => _isActive ?? true;

  factory AddUserModel.fromJson(Map<String, dynamic> json) =>
      _$AddUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddUserModelToJson(this);

  factory AddUserModel.fromString(String jsonString) =>
      AddUserModel.fromJson(json.decode(jsonString));

  @override
  String toString() => jsonEncode(toJson());
}
