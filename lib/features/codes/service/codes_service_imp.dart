part of 'codes_service.dart';

@Injectable(as: CodesService)
class CodesServiceImp implements CodesService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<CodeModel>> getCodes({
    int perPage = 10,
    required int page,
  }) async {
    try {
      final perPageParam = "per_page=$perPage";
      final pageParam = "page=$page";
      final response = await dio.get("/v1/admin/codes?$pageParam&$perPageParam");
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => CodeModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CodeModel> addCode(
    AddCodeModel addCodeModel, {
    required bool isAdd,
    int? id,
  }) async {
    final endpoint = isAdd ? "/api/codes" : "/api/codes/$id";
    try {
      final map = addCodeModel.toJson();
      final response = await dio.post(endpoint, data: map);
      return CodeModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
