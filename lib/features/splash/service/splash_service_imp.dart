part of "splash_service.dart";

@Injectable(as: SplashSerivce)
class SplashSerivceImp implements SplashSerivce {
  final dio = DioClient();

  @override
  Future<bool> checkVersion() async {
    try {
      final response = await dio.get("/v1/check-version");
      final isV1Int = response.data["is_v1"] as int;
      return isV1Int == 1;
    } catch (e, stackTrace) {
      if (kDebugMode) print("stackTrace of checkVersion : $stackTrace");
      rethrow;
    }
  }
}
