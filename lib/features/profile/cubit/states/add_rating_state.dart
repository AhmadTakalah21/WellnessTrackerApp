part of '../profile_cubit.dart';

@immutable
class AddRatingState extends GeneralProfileState {}

final class AddRatingLoading extends AddRatingState {}

final class AddRatingSuccess extends AddRatingState {
  final RatingModel rating;
  final String message;

  AddRatingSuccess(this.rating, this.message);
}

final class AddRatingFail extends AddRatingState {
  final String error;

  AddRatingFail(this.error);
}
