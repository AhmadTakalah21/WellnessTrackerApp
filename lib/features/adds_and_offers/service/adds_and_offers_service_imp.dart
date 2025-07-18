part of 'adds_and_offers_service.dart';

@Injectable(as: AddsAndOffersService)
class AddsAndOffersServiceImp implements AddsAndOffersService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<AdvModel>> getAdvs(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final response = await dio.get(
          "/v1/${role.getApiRoute}/advertisements?$pageParam&$perPageParam");
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
  Future<void> addAdv(AddAdvModel model, {XFile? image, int? id}) async {
    final isAdd = id == null;
    final endpoint = isAdd ? "" : "/$id";
    try {
      final map = model.toJson();

      if (!isAdd) {
        map["_method"] = "put";
      }
      if (image != null) {
        map['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      final formData = FormData.fromMap(map);
      await dio.post("/v1/admin/advertisements$endpoint", data: formData);
      // await dio.postOrPut(
      //   "/v1/admin/advertisements$endpoint",
      //   isAdd: isAdd,
      //   data: formData,
      // );
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
