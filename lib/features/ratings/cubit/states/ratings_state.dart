part of '../ratings_cubit.dart';

@immutable
sealed class RatingsState extends GeneralRatingsState {}

final class RatingsInitial extends RatingsState {}

final class RatingsLoading extends RatingsState {}

final class RatingsSuccess extends RatingsState {
  final List<RatingModel> ratings;
  final bool isLoadingMore;
  final bool hasMore;

  RatingsSuccess(
    this.ratings, {
    this.isLoadingMore = false,
    this.hasMore = true,
  });
}

final class RatingsEmpty extends RatingsState {
  final String message;

  RatingsEmpty(this.message);
}

final class RatingsFail extends RatingsState {
  final String error;

  RatingsFail(this.error);
}
