part of '../meals_cubit.dart';

@immutable
sealed class MealsState extends GeneralMealsState {}

class MealsLoading extends MealsState {}

class MealsSuccess extends MealsState {
  final PaginatedModel<MealModel> meals;
  final String? emptyMessage;

  MealsSuccess(this.meals, this.emptyMessage);
}

class MealsEmpty extends MealsState {
  final String message;

  MealsEmpty(this.message);
}

class MealsFail extends MealsState {
  final String error;

  MealsFail(this.error);
}
