part of '../codes_cubit.dart';

@immutable
class AddCodeState extends GeneralCodesState {}

final class AddCodeLoading extends AddCodeState {}

final class AddCodeSuccess extends AddCodeState {
  final CodeModel code;
  final String message;

  AddCodeSuccess(this.code, this.message);
}

final class AddCodeFail extends AddCodeState {
  final String error;

  AddCodeFail(this.error);
}
