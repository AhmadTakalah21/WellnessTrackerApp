part of 'meal_plans_service.dart';

@Injectable(as: MealPlansService)
class MealPlanServiceImp implements MealPlansService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<MealPlanModel>> getMealPlans(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final endpoint =
          "/v1/${role.getApiRoute}/meal-plans?$pageParam&$perPageParam";

      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => MealPlanModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<MealPlanModel> addMealPlan(
    AddMealPlanModel model, {
    int? id,
  }) async {
    final isAdd = id == null;
    final endpoint =
        isAdd ? "/v1/dietitian/meal-plans" : "/v1/dietitian/meal-plans/$id";

    try {
      final map = model.toJson();
      if (!isAdd) {
        map["_method"] = "PUT";
      }

      final response = await dio.post(endpoint, data: map);
      final data = response.data["data"] as Map<String, dynamic>;
      return MealPlanModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
