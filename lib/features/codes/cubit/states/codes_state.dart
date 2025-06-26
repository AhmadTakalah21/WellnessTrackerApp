part of '../codes_cubit.dart';

@immutable
sealed class CodesState extends GeneralCodesState {}

final class CodesInitial extends CodesState {}

final class CodesLoading extends CodesState {}

final class CodesSuccess extends CodesState {
  final List<CodeModel> codes;

  CodesSuccess(this.codes);
}

final class CodesEmpty extends CodesState {
  final String message;

  CodesEmpty(this.message);
}

final class CodesFail extends CodesState {
  final String error;

  CodesFail(this.error);
}
