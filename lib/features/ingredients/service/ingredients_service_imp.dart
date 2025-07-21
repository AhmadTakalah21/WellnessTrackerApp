part of 'ingredients_service.dart';

@Injectable(as: IngredientsService)
class IngredientsServiceImp implements IngredientsService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<IngredientModel>> getIngredients({
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final endpoint = "/v1/dietitian/ingredients?$pageParam&$perPageParam";

      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => IngredientModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<IngredientModel> addIngredient(
    AddIngredientModel model, {
    int? id,
  }) async {
    final isAdd = id == null;
    final endpoint =
        isAdd ? "/v1/admin/ingredients" : "/v1/admin/ingredients/$id";

    try {
      final map = model.toJson();
      if (!isAdd) {
        map["_method"] = "PUT";
      }

      final response = await dio.post(endpoint, data: map);
      final data = response.data["data"] as Map<String, dynamic>;
      return IngredientModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
