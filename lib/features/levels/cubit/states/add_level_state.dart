part of '../levels_cubit.dart';

@immutable
abstract class AddLevelState extends GeneralLevelsState {}

class AddLevelLoading extends AddLevelState {}

class AddLevelSuccess extends AddLevelState {
  final LevelModel level;
  final String message;

  AddLevelSuccess(this.level, this.message);
}

class AddLevelFail extends AddLevelState {
  final String error;

  AddLevelFail(this.error);
}
