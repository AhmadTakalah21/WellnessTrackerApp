part of '../customers_cubit.dart';

@immutable
sealed class EvaluateSubscriberState extends GeneralCustomersState {}

final class EvaluateSubscriberInitial extends EvaluateSubscriberState {}

final class EvaluateSubscriberLoading extends EvaluateSubscriberState {}

final class EvaluateSubscriberSuccess extends EvaluateSubscriberState {
  final String message;

  EvaluateSubscriberSuccess(this.message);
}

final class EvaluateSubscriberFail extends EvaluateSubscriberState {
  final String error;

  EvaluateSubscriberFail(this.error);
}
