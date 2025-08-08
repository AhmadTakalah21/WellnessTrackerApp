part of '../statistics_cubit.dart';

@immutable
class StatisticsState extends GeneralStatisticsState {}

final class StatisticsInitial extends StatisticsState {}

final class StatisticsLoading extends StatisticsState {}

final class StatisticsSuccess extends StatisticsState {
  final StatsModel statistics;
  StatisticsSuccess(this.statistics);
}

final class StatisticsFail extends StatisticsState {
  final String error;
  StatisticsFail(this.error);
}
