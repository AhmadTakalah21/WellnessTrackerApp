import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/settings/model/settings_model/settings_model.dart';
import 'package:wellnesstrackerapp/features/settings/model/update_settings_model/update_settings_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';

part 'settings_service_imp.dart';

abstract class SettingsService {
  Future<SettingsModel> getSettings();
  Future<SettingsModel> updateSettings(UpdateSettingsModel updateSettingsModel);
}
