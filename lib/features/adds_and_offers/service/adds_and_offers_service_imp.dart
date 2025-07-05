part of 'adds_and_offers_service.dart';

@Injectable(as: AddsAndOffersService)
class AddsAndOffersServiceImp implements AddsAndOffersService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<AdvModel>> getAdvs({
    int perPage = 10,
    required int page,
  }) async {
    try {
      final perPageParam = "per_page=$perPage";
      final pageParam = "page=$page";
      final response =
          await dio.get("/v1/admin/adds_and_offers?$pageParam&$perPageParam");
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => AdvModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }
}
