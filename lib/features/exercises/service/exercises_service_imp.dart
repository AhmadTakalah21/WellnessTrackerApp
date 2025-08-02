part of 'exercises_service.dart';

@Injectable(as: ExercisesService)
class ExercisesServiceImp implements ExercisesService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<ExerciseModel>> getExercises({
    int? perPage = 10,
    int? page,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final endpoint = "/v1/coach/exercises?$pageParam&$perPageParam";

      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => ExerciseModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<ExerciseModel> addExercise(AddExerciseModel model, {int? id}) async {
    final isAdd = id == null;
    final endpoint = isAdd ? "/v1/coach/exercises" : "/v1/coach/exercises/$id";

    try {
      final map = model.toJson();
      if (!isAdd) {
        map["_method"] = "PUT";
      }

      for (var index = 0; index < model.description.repeats.length; index++) {
        final repeat = model.description.repeats[index];
        map.addAll({"description[repeats][$index]": repeat});
      }

      final response = await dio.post(endpoint, data: FormData.fromMap(map));
      final data = response.data["data"] as Map<String, dynamic>;
      return ExerciseModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
