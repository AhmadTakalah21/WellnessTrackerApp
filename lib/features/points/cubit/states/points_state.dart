part of '../points_cubit.dart';

@immutable
class PointsState extends GeneralPointsState {}

final class PointsInitial extends PointsState {}

final class PointsLoading extends PointsState {}

final class PointsSuccess extends PointsState {
  final PointsModel points;

  PointsSuccess(this.points);
}

final class PointsFail extends PointsState {
  final String error;

  PointsFail(this.error);
}
