part of '../levels_cubit.dart';

@immutable
sealed class LevelsState extends GeneralLevelsState {}

class LevelsLoading extends LevelsState {}

class LevelsSuccess extends LevelsState {
  final PaginatedModel<LevelModel> levels;
  final String? emptyMessage;

  LevelsSuccess(this.levels, this.emptyMessage);
}

class LevelsEmpty extends LevelsState {
  final String message;

  LevelsEmpty(this.message);
}

class LevelsFail extends LevelsState {
  final String error;

  LevelsFail(this.error);
}
