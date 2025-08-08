part of '../points_cubit.dart';

class AddPointsGuidelineState extends GeneralPointsState{}

final class AddPointsGuidelineLoading extends AddPointsGuidelineState {}

final class AddPointsGuidelineSuccess extends AddPointsGuidelineState {
  final String message;

  AddPointsGuidelineSuccess(this.message);
}

final class AddPointsGuidelineFail extends AddPointsGuidelineState {
  final String error;

  AddPointsGuidelineFail(this.error);
}