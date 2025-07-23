part of 'meals_service.dart';

@Injectable(as: MealsService)
class MealsServiceImp implements MealsService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<MealModel>> getMeals({
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final endpoint = "/v1/dietitian/meals?$pageParam&$perPageParam";

      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => MealModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<MealModel> addMeal(
    AddMealModel model, {
    int? id,
  }) async {
    final isAdd = id == null;
    final endpoint = isAdd ? "/v1/admin/dietitian" : "/v1/dietitian/meals/$id";

    try {
      final map = model.toJson();
      if (!isAdd) {
        map["_method"] = "PUT";
      }

      final response = await dio.post(endpoint, data: map);
      final data = response.data["data"] as Map<String, dynamic>;
      return MealModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
