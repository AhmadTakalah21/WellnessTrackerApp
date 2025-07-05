part of '../auth_cubit.dart';

@immutable
class AddInfoState extends AuthState{}

class AddInfoInitial extends AddInfoState {}

class AddInfoLoading extends AddInfoState {}

class AddInfoSuccess extends AddInfoState {
  final String message;

  AddInfoSuccess(this.message);
}

class AddInfoFail extends AddInfoState {
  final String error;

  AddInfoFail(this.error);
}
