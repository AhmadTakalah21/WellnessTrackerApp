part of '../customers_cubit.dart';

@immutable
sealed class AssignPlanState extends GeneralCustomersState {}

final class AssignPlanInitial extends AssignPlanState {}

final class AssignPlanLoading extends AssignPlanState {}

final class AssignPlanSuccess extends AssignPlanState {
  final String message;

  AssignPlanSuccess(this.message);
}

final class AssignPlanFail extends AssignPlanState {
  final String error;

  AssignPlanFail(this.error);
}
