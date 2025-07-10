part of 'level_service.dart';

@Injectable(as: LevelsService)
class LevelsServiceImp implements LevelsService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<LevelModel>> getLevels({
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final endpoint = "/v1/admin/levels?$pageParam&$perPageParam";
      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => LevelModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }
}
