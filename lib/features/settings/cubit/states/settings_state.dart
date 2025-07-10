part of '../settings_cubit.dart';

@immutable
class SettingsState extends GeneralSettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsSuccess extends SettingsState {
  final SettingsModel settings;

  SettingsSuccess(this.settings);
}

final class SettingsFail extends SettingsState {
  final String error;

  SettingsFail(this.error);
}
