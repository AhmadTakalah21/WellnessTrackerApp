part of '../meals_cubit.dart';

abstract class GeneralMealsState {}

class GeneralMealsInitial extends GeneralMealsState {}

class SelectedIngredientsState extends GeneralMealsState {
  final List<IngredientItemToShowModel> ingredients;

  SelectedIngredientsState(this.ingredients);
}
