part of '../customers_cubit.dart';

@immutable
class CustomersState extends GeneralCustomersState {}

class CustomersInitial extends CustomersState {}

class CustomersLoading extends CustomersState {}

class CustomersSuccess extends CustomersState {
  final PaginatedModel<CustomerModel> customers;
  final String? emptyMessage;

  CustomersSuccess(this.customers, this.emptyMessage);
}

class CustomersEmpty extends CustomersState {
  final String message;

  CustomersEmpty(this.message);
}

class CustomersFail extends CustomersState {
  final String error;

  CustomersFail(this.error);
}
