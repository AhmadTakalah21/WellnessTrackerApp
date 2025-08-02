part of '../exercise_plans_cubit.dart';

@immutable
abstract class GeneralExercisePlansState {}

class GeneralExercisePlansInitial extends GeneralExercisePlansState {}

class PlanDaysState extends GeneralExercisePlansState {
  PlanDaysState(this.planDays);
  final List<ExercisePlanDayItemToShowModel> planDays;
}
