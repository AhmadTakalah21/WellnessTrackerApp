part of '../exercises_cubit.dart';

@immutable
abstract class AddExerciseState extends GeneralExercisesState {}

class AddExerciseLoading extends AddExerciseState {}

class AddExerciseSuccess extends AddExerciseState {
  final ExerciseModel exercise;
  final String message;

  AddExerciseSuccess(this.exercise, this.message);
}

class AddExerciseFail extends AddExerciseState {
  final String error;

  AddExerciseFail(this.error);
}
