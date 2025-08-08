part of '../items_cubit.dart';

@immutable
class BuyItemState extends GeneralItemsState {}

final class BuyItemLoading extends BuyItemState {}

final class BuyItemSuccess extends BuyItemState {
  final String message;

  BuyItemSuccess(this.message);
}

final class BuyItemFail extends BuyItemState {
  final String error;

  BuyItemFail(this.error);
}
