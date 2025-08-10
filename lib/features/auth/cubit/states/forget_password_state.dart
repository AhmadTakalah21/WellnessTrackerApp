part of '../auth_cubit.dart';

@immutable
abstract class PasswordState extends AuthState {}

class PasswordInitial extends PasswordState {}

class ForgotPasswordLoading extends PasswordState {}

class ForgotPasswordSuccess extends PasswordState {
  final String message;
  ForgotPasswordSuccess(this.message);
}

class ForgotPasswordFail extends PasswordState {
  final String error;
  ForgotPasswordFail(this.error);
}

class VerifyResetCodeLoading extends PasswordState {}

class VerifyResetCodeSuccess extends PasswordState {
  final String message;
  VerifyResetCodeSuccess(this.message);
}

class VerifyResetCodeFail extends PasswordState {
  final String error;
  VerifyResetCodeFail(this.error);
}

class ResetPasswordLoading extends PasswordState {}

class ResetPasswordSuccess extends PasswordState {
  final String message;
  ResetPasswordSuccess(this.message);
}

class ResetPasswordFail extends PasswordState {
  final String error;
  ResetPasswordFail(this.error);
}
