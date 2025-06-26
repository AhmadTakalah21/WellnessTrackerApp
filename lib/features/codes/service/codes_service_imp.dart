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
      final response = await dio.get("/v1/admin/codes");
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => CodeModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }
}
