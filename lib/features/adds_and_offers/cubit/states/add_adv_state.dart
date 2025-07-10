part of '../adds_and_offers_cubit.dart';

@immutable
sealed class AddAdvState extends GeneralAddsAndOffersState {}

final class AddAdvInitial extends AddAdvState {}

final class AddAdvLoading extends AddAdvState {}

final class AddAdvSuccess extends AddAdvState {
  final String message;

  AddAdvSuccess(this.message);
}

final class AddAdvFail extends AddAdvState {
  final String error;

  AddAdvFail(this.error);
}
