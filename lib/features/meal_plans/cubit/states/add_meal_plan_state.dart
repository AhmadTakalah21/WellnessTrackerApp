part of '../meal_plans_cubit.dart';

@immutable
abstract class AddMealPlanState extends GeneralMealPlansState {}

class AddMealPlanLoading extends AddMealPlanState {}

class AddMealPlanSuccess extends AddMealPlanState {
  final MealPlanModel mealPlan;
  final String message;

  AddMealPlanSuccess(this.mealPlan, this.message);
}

class AddMealPlanFail extends AddMealPlanState {
  final String error;

  AddMealPlanFail(this.error);
}
