part of '../ratings_cubit.dart';

@immutable
sealed class RatingsState extends GeneralRatingsState {}

final class RatingsInitial extends RatingsState {}

final class RatingsLoading extends RatingsState {}

final class RatingsSuccess extends RatingsState {
  final PaginatedModel<RatingModel> ratings;
  final String? emptyMessage;

  RatingsSuccess(this.ratings, this.emptyMessage);
}

final class RatingsEmpty extends RatingsState {
  final String message;

  RatingsEmpty(this.message);
}

final class RatingsFail extends RatingsState {
  final String error;

  RatingsFail(this.error);
}
