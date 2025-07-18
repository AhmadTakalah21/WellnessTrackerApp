part of 'level_service.dart';

@Injectable(as: LevelsService)
class LevelsServiceImp implements LevelsService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<LevelModel>> getLevels(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final endpoint =
          "/v1/${role.getApiRoute}/levels?$pageParam&$perPageParam";
      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => LevelModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LevelModel> addLevel(
    AddLevelModel model, {
    XFile? image,
    int? id,
  }) async {
    final isAdd = id == null;
    final endpoint = isAdd ? "/v1/admin/levels" : "/v1/admin/levels/$id";
    try {
      final map = model.toJson();
      if (image != null) {
        map['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      final formData = FormData.fromMap(map);

      final response = await dio.postOrPut(
        endpoint,
        isAdd: isAdd,
        data: formData,
      );

      final data = response.data["data"] as Map<String, dynamic>;
      return LevelModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
