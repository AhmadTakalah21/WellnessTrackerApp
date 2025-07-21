part of '../ingredients_cubit.dart';

@immutable
abstract class AddIngredientState extends GeneralIngredientsState {}

class AddIngredientLoading extends AddIngredientState {}

class AddIngredientSuccess extends AddIngredientState {
  final IngredientModel ingredient;
  final String message;

  AddIngredientSuccess(this.ingredient, this.message);
}

class AddIngredientFail extends AddIngredientState {
  final String error;

  AddIngredientFail(this.error);
}
