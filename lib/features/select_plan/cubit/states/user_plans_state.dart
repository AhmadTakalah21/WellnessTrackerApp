part of '../user_plans_cubit.dart';

@immutable
 class UserPlansState extends GeneralUserPlansState{}

final class UserPlansInitial extends UserPlansState {}

final class UserPlansLoading extends UserPlansState {}

final class UserPlansSuccess extends UserPlansState {
  final List<UserPlanModel>plans;

  UserPlansSuccess(this.plans);
}


final class UserPlansEmpty extends UserPlansState {
  final String message;

  UserPlansEmpty(this.message);
}

final class UserPlansFail extends UserPlansState {
  final String error;

  UserPlansFail(this.error);
}
