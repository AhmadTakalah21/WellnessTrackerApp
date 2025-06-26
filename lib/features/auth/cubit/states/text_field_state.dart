part of '../auth_cubit.dart';

class TextFieldState extends AuthState {
  TextFieldState(this.type, {this.error});

  final TextFieldType type;
  final String? error;
}

enum TextFieldType {
  username,
  fullName,
  email,
  password,
  confirmPassword,
  code,
}
