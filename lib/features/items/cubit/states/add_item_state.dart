part of '../items_cubit.dart';

@immutable
class AddItemState extends GeneralItemsState {}

final class AddItemLoading extends AddItemState {}

final class AddItemSuccess extends AddItemState {
  final ItemModel item;
  final String message;

  AddItemSuccess(this.item, this.message);
}

final class AddItemFail extends AddItemState {
  final String error;

  AddItemFail(this.error);
}
