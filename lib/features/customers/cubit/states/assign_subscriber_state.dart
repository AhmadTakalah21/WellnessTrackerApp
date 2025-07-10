part of '../customers_cubit.dart';

@immutable
sealed class AssignSubscriberState extends GeneralCustomersState {}

final class AssignSubscriberInitial extends AssignSubscriberState {}

final class AssignSubscriberLoading extends AssignSubscriberState {}

final class AssignSubscriberSuccess extends AssignSubscriberState {
  final String message;

  AssignSubscriberSuccess(this.message);
}

final class AssignSubscriberFail extends AssignSubscriberState {
  final String error;

  AssignSubscriberFail(this.error);
}
