part of '../meal_plans_cubit.dart';

@immutable
sealed class MealPlansState extends GeneralMealPlansState {}

class MealPlansLoading extends MealPlansState {}

class MealPlansSuccess extends MealPlansState {
  final PaginatedModel<MealPlanModel> mealPlans;
  final String? emptyMessage;

  MealPlansSuccess(this.mealPlans, this.emptyMessage);
}

class MealPlansEmpty extends MealPlansState {
  final String message;

  MealPlansEmpty(this.message);
}

class MealPlansFail extends MealPlansState {
  final String error;

  MealPlansFail(this.error);
}
