part of '../customers_cubit.dart';

@immutable
sealed class SubscriberEvaluationState extends GeneralCustomersState {}

final class SubscriberEvaluationInitial extends SubscriberEvaluationState {}

final class SubscriberEvaluationLoading extends SubscriberEvaluationState {}

final class SubscriberEvaluationSuccess extends SubscriberEvaluationState {
  final CustomerEvaluationModel evaluation;

  SubscriberEvaluationSuccess(this.evaluation);
}

final class SubscriberEvaluationFail extends SubscriberEvaluationState {
  final String error;

  SubscriberEvaluationFail(this.error);
}
