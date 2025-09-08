part of '../exercises_cubit.dart';

abstract class GeneralExercisesState {}

class GeneralExercisesInitial extends GeneralExercisesState {}

class RoundsUpdatedState extends GeneralExercisesState {
  final List<int> repeats;

  RoundsUpdatedState(this.repeats);
}
