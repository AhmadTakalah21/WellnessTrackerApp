part of '../splash_cubit.dart';

@immutable
class CheckVersionState extends GeneralSplashState {}

final class CheckVersionInitial extends CheckVersionState {}

final class CheckVersionLoading extends CheckVersionState {}

final class CheckVersionSuccess extends CheckVersionState {
  final bool isV1;

  CheckVersionSuccess(this.isV1);
}
