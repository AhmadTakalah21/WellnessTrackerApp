part of '../customers_cubit.dart';

@immutable
sealed class SubscriberEvaluationState extends GeneralCustomersState {}

final class SubscriberEvaluationInitial extends SubscriberEvaluationState {}

final class SubscriberEvaluationLoading extends SubscriberEvaluationState {}

final class SubscriberEvaluationSuccess extends SubscriberEvaluationState {
  final List<CustomerEvaluationModel> evaluations;

  SubscriberEvaluationSuccess(this.evaluations);
}

final class SubscriberEvaluationFail extends SubscriberEvaluationState {
  final String error;

  SubscriberEvaluationFail(this.error);
}
