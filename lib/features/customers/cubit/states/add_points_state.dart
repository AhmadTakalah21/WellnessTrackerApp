part of '../customers_cubit.dart';

@immutable
sealed class AddPointsState extends GeneralCustomersState {}

final class AddPointsInitial extends AddPointsState {}

final class AddPointsLoading extends AddPointsState {}

final class AddPointsSuccess extends AddPointsState {
  final String message;

  AddPointsSuccess(this.message);
}

final class AddPointsFail extends AddPointsState {
  final String error;

  AddPointsFail(this.error);
}
