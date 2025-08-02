part of '../meal_plans_cubit.dart';

@immutable
abstract class GeneralMealPlansState {}

class GeneralMealPlansInitial extends GeneralMealPlansState {}

class MealPlanDaysState extends GeneralMealPlansState {
  MealPlanDaysState(this.planDays);
  final List<PlanDayItemToShowModel> planDays;
}
