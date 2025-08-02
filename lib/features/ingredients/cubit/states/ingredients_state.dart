part of '../ingredients_cubit.dart';

@immutable
sealed class IngredientsState extends GeneralIngredientsState {}

class IngredientsLoading extends IngredientsState {}

class IngredientsSuccess extends IngredientsState {
  final PaginatedModel<IngredientModel> ingredients;
  final List<IngredientWithQuantityModel>? selected;
  final String? emptyMessage;

  IngredientsSuccess(this.ingredients, this.selected, this.emptyMessage);
}

class IngredientsEmpty extends IngredientsState {
  final String message;

  IngredientsEmpty(this.message);
}

class IngredientsFail extends IngredientsState {
  final String error;

  IngredientsFail(this.error);
}
