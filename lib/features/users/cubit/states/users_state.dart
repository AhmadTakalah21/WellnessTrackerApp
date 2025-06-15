part of '../users_cubit.dart';

@immutable
sealed class UsersState extends GeneralUsersState {}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class UsersSuccess extends UsersState {
  final PaginatedModel<UserModel> users;
  final String? emptyMessage;

  UsersSuccess(this.users, this.emptyMessage);
}

final class UsersEmpty extends UsersState {
  final String message;

  UsersEmpty(this.message);
}

final class UsersFail extends UsersState {
  final String error;

  UsersFail(this.error);
}
