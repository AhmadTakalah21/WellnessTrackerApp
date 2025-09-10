part of 'settings_service.dart';

@Injectable(as: SettingsService)
class SettingsServiceImp implements SettingsService {
  final dio = DioClient();

  @override
  Future<SettingsModel> getSettings() async {
    try {
      final response = await dio.get("/v1/users/settings");
      final json = response.data["data"] as Map<String, dynamic>;
      return SettingsModel.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SettingsModel> updateSettings(
    UpdateSettingsModel updateSettingsModel,
  ) async {
    const endpoint = "/v1/admin/settings";
    try {
      final map = updateSettingsModel.toJson();
      final response = await dio.put(endpoint, data: map);
      final json = response.data["data"] as Map<String, dynamic>;
      return SettingsModel.fromJson(json);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateLocale(Locale locale) async {
    try {
      await dio.post("/v1/update_local", data: {"locale": locale.languageCode});
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
