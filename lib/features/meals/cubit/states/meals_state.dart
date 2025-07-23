part of '../meals_cubit.dart';

@immutable
sealed class MealState extends GeneralMealsState {}

class MealsLoading extends MealState {}

class MealsSuccess extends MealState {
  final PaginatedModel<MealModel> meals;
  final String? emptyMessage;

  MealsSuccess(this.meals, this.emptyMessage);
}

class MealsEmpty extends MealState {
  final String message;

  MealsEmpty(this.message);
}

class MealsFail extends MealState {
  final String error;

  MealsFail(this.error);
}
