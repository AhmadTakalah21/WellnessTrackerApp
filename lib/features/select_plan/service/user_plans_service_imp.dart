part of 'user_plans_service.dart';

@Injectable(as: UserPlansService)
class UserPlansServiceImp implements UserPlansService {
  final dio = DioClient();

  @override
  Future<List<UserPlanModel>> getPlans() async {
    try {
      final response = await dio.get("/v1/admin/plans?");
      final data = response.data["data"] as List;
      return data
          .map((e) => UserPlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
          
    } catch (e, stackTrance) {
      if (kDebugMode) print(stackTrance);
      rethrow;
    }
  }
}
