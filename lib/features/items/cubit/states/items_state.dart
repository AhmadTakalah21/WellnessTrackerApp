part of '../items_cubit.dart';

@immutable
sealed class ItemsState extends GeneralItemsState {}

final class ItemsInitial extends ItemsState {}

final class ItemsLoading extends ItemsState {}

final class ItemsSuccess extends ItemsState {
  final PaginatedModel<ItemModel> items;

  ItemsSuccess(this.items);
}

final class ItemsEmpty extends ItemsState {
  final String message;

  ItemsEmpty(this.message);
}

final class ItemsFail extends ItemsState {
  final String error;

  ItemsFail(this.error);
}
