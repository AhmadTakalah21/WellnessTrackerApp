part of 'user_plans_service.dart';

@Injectable(as: UserPlansService)
class UserPlansServiceImp implements UserPlansService {
  final dio = DioClient();

  @override
  Future<UserPlansModel> getPlans() async {
    try {
      final response = await dio.get("/v1/users/subscriptions");
      final data = response.data["data"] as Map<String, dynamic>;
      return UserPlansModel.fromJson(data);
    } catch (e, stackTrance) {
      if (kDebugMode) print(stackTrance);
      rethrow;
    }
  }
}
