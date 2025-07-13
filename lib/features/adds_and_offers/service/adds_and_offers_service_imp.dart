part of 'adds_and_offers_service.dart';

@Injectable(as: AddsAndOffersService)
class AddsAndOffersServiceImp implements AddsAndOffersService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<AdvModel>> getAdvs({
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final response =
          await dio.get("/v1/admin/advertisements?$pageParam&$perPageParam");
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => AdvModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> addAdv(
    AddAdvModel model, {
    required bool isAdd,
    XFile? image,
    int? id,
  }) async {
    final endpoint = isAdd ? "" : "/$id";
    try {
      final map = model.toJson();
      if (image != null) {
        map['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      final formData = FormData.fromMap(map);
      await dio.postOrPut(
        "/v1/admin/advertisements$endpoint",
        isAdd: isAdd,
        data: formData,
      );
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
