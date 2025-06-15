part of '../users_cubit.dart';

@immutable
class AddUserState extends GeneralUsersState {}

final class AddUserLoading extends AddUserState {}

final class AddUserSuccess extends AddUserState {
  final UserModel user;
  final String message;

  AddUserSuccess(this.user, this.message);
}

final class AddUserFail extends AddUserState {
  final String error;

  AddUserFail(this.error);
}
