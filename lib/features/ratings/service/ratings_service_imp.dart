part of 'ratings_service.dart';

@Injectable(as: RatingsService)
class RatingsServiceImp implements RatingsService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<RatingModel>> getRatings({
    int perPage = 10,
    required int page,
  }) async {
    try {
      final perPageParam = "per_page=$perPage";
      final pageParam = "page=$page";
      final response =
          await dio.get("/v1/admin/ratings?$pageParam&$perPageParam");
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => RatingModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }
}
