part of '../exercises_cubit.dart';

@immutable
sealed class ExercisesState extends GeneralExercisesState {}

class ExercisesLoading extends ExercisesState {}

class ExercisesSuccess extends ExercisesState {
  final PaginatedModel<ExerciseModel> exercises;
  final String? emptyMessage;

  ExercisesSuccess(this.exercises, this.emptyMessage);
}

class ExercisesEmpty extends ExercisesState {
  final String message;

  ExercisesEmpty(this.message);
}

class ExercisesFail extends ExercisesState {
  final String error;

  ExercisesFail(this.error);
}
