part of '../exercise_plans_cubit.dart';

@immutable
sealed class ExercisePlansState extends GeneralExercisePlansState {}

class ExercisePlansLoading extends ExercisePlansState {}

class ExercisePlansSuccess extends ExercisePlansState {
  final PaginatedModel<ExercisePlanModel> exercisePlans;
  final String? emptyMessage;

  ExercisePlansSuccess(this.exercisePlans, this.emptyMessage);
}

class ExercisePlansEmpty extends ExercisePlansState {
  final String message;

  ExercisePlansEmpty(this.message);
}

class ExercisePlansFail extends ExercisePlansState {
  final String error;

  ExercisePlansFail(this.error);
}
