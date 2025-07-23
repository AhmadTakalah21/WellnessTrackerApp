part of '../customers_cubit.dart';

@immutable
sealed class AssignMealPlanState extends GeneralCustomersState {}

final class AssignMealPlanInitial extends AssignMealPlanState {}

final class AssignMealPlanLoading extends AssignMealPlanState {}

final class AssignMealPlanSuccess extends AssignMealPlanState {
  final String message;

  AssignMealPlanSuccess(this.message);
}

final class AssignMealPlanFail extends AssignMealPlanState {
  final String error;

  AssignMealPlanFail(this.error);
}
