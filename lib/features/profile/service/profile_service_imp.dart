part of 'profile_service.dart';

@Injectable(as: ProfileService)
class ProfileServiceImp implements ProfileService {
  final dio = DioClient();

  @override
  Future<RatingModel> addRating(AddRateModel addRateModel, {int? id}) async {
    final isAdd = id == null;
    final endpoint = isAdd ? "/v1/users/ratings" : "/v1/users/ratings/$id";
    try {
      final map = addRateModel.toJson();
      final response = await dio.postOrPut(endpoint, isAdd: isAdd, data: map);
      final data = response.data["data"] as Map<String, dynamic>;
      return RatingModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<CustomerModel> getProfile() async {
    try {
      final response = await dio.get("/v1/users");
      final data = response.data["data"] as Map<String, dynamic>;
      return CustomerModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
