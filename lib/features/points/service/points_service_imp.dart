part of "points_service.dart";

@Injectable(as: PointsService)
class PointsServiceImp implements PointsService {
  final dio = DioClient();

  @override
  Future<PointsModel> getPoints() async {
    try {
      final response = await dio.get("/v1/users/points");
      final data = response.data["data"] as Map<String, dynamic>;
      return PointsModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print("stackTrace : $stackTrace");
      rethrow;
    }
  }

  @override
  Future<void> addPointsGuideLine(AddPointsGuidelineModel model,
      {int? id}) async {
    final isAdd = id == null;
    final endpoint = isAdd ? "guidelines" : "guidelines/$id";
    try {
      final map = model.toJson();
      await dio.postOrPut("/v1/admin/$endpoint", isAdd: isAdd, data: map);
    } catch (e, stackTrace) {
      if (kDebugMode) print("stackTrace : $stackTrace");
      rethrow;
    }
  }

  @override
  Future<PaginatedModel<PointsGuidelineModel>> getPointsGuideLines(
    UserRoleEnum role, {
    int perPage = 10,
    required int page,
  }) async {
    try {
      final perPageParam = "per_page=$perPage";
      final pageParam = "page=$page";
      final params = "$pageParam&$perPageParam";
      final endpoint = "/v1/${role.getApiRoute}/guidelines?$params";
      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PointsGuidelineModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }
}
