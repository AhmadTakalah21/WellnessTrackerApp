part of '../settings_cubit.dart';

@immutable
class UpdateSettingsState extends GeneralSettingsState {}

final class UpdateSettingsLoading extends UpdateSettingsState {}

final class UpdateSettingsSuccess extends UpdateSettingsState {
  final SettingsModel settings;
  final String message;

  UpdateSettingsSuccess(this.settings, this.message);
}

final class UpdateSettingsFail extends UpdateSettingsState {
  final String error;

  UpdateSettingsFail(this.error);
}
