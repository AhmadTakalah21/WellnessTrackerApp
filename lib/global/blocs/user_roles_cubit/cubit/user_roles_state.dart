part of 'user_roles_cubit.dart';

@immutable
sealed class UserRolesState {}

final class UserRolesInitial extends UserRolesState {}

final class UserRolesLoading extends UserRolesState {}

final class UserRolesSuccess extends UserRolesState {
  final List<UserRoleModel> userRoles;

  UserRolesSuccess(this.userRoles);
}

final class UserRolesEmpty extends UserRolesState {
  final String message;

  UserRolesEmpty(this.message);
}

final class UserRolesFail extends UserRolesState {
  final String error;

  UserRolesFail(this.error);
}
