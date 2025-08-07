part of '../customers_cubit.dart';

@immutable
sealed class UpdateCustomerInfoState extends GeneralCustomersState {}

final class UpdateCustomerInfoInitial extends UpdateCustomerInfoState {}

final class UpdateCustomerInfoLoading extends UpdateCustomerInfoState {}

final class UpdateCustomerInfoSuccess extends UpdateCustomerInfoState {
  final String message;

  UpdateCustomerInfoSuccess(this.message);
}

final class UpdateCustomerInfoFail extends UpdateCustomerInfoState {
  final String error;

  UpdateCustomerInfoFail(this.error);
}
