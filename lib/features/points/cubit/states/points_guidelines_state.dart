part of '../points_cubit.dart';

@immutable
sealed class PointsGuidelinesState extends GeneralPointsState {}

final class PointsGuidelinesInitial extends PointsGuidelinesState {}

final class PointsGuidelinesLoading extends PointsGuidelinesState {}

final class PointsGuidelinesSuccess extends PointsGuidelinesState {
  final PaginatedModel<PointsGuidelineModel> pointsGuidelines;
  final String? emptyMessage;

  PointsGuidelinesSuccess(this.pointsGuidelines, this.emptyMessage);
}

final class PointsGuidelinesEmpty extends PointsGuidelinesState {
  final String message;

  PointsGuidelinesEmpty(this.message);
}

final class PointsGuidelinesFail extends PointsGuidelinesState {
  final String error;

  PointsGuidelinesFail(this.error);
}
