part of 'statistics_service.dart';

@Injectable(as: StatisticsService)
class StatisticsServiceImp implements StatisticsService {
  final dio = DioClient();

  @override
  Future<StatsModel> getStats() async {
    try {
      final response = await dio.get("/v1/admin/statistics");
      final data = response.data["data"] as Map<String, dynamic>;
      return StatsModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
