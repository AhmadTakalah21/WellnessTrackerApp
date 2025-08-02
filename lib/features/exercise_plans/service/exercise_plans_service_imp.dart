part of 'exercise_plans_service.dart';

@Injectable(as: ExercisePlansService)
class ExercisePlansServiceImp implements ExercisePlansService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<ExercisePlanModel>> getExercisePlans(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final endpoint = "/v1/${role.getApiRoute}/exercise-plans?$pageParam&$perPageParam";

      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => ExercisePlanModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<ExercisePlanModel> addExercisePlan(
    AddExercisePlanModel model, {
    int? id,
  }) async {
    final isAdd = id == null;
    final endpoint =
        isAdd ? "/v1/coach/exercise-plans" : "/v1/coach/exercise-plans/$id";

    try {
      final map = model.toJson();
      if (!isAdd) {
        map["_method"] = "PUT";
      }

      final response = await dio.post(endpoint, data: map);
      final data = response.data["data"] as Map<String, dynamic>;
      return ExercisePlanModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
