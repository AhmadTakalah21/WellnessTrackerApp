part of '../exercise_plans_cubit.dart';

@immutable
abstract class AddExercisePlanState extends GeneralExercisePlansState {}

class AddExercisePlanLoading extends AddExercisePlanState {}

class AddExercisePlanSuccess extends AddExercisePlanState {
  final ExercisePlanModel exercisePlan;
  final String message;

  AddExercisePlanSuccess(this.exercisePlan, this.message);
}

class AddExercisePlanFail extends AddExercisePlanState {
  final String error;

  AddExercisePlanFail(this.error);
}
