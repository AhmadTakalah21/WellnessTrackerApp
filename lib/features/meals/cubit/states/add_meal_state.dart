part of '../meals_cubit.dart';

@immutable
abstract class AddMealState extends GeneralMealsState {}

class AddMealLoading extends AddMealState {}

class AddMealSuccess extends AddMealState {
  final MealModel meal;
  final String message;

  AddMealSuccess(this.meal, this.message);
}

class AddMealFail extends AddMealState {
  final String error;

  AddMealFail(this.error);
}
