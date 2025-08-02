part of 'customers_service.dart';

@Injectable(as: CustomersService)
class CustomersServiceImp implements CustomersService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<CustomerModel>> getCustomers(
    UserRoleEnum role, {
    int? page,
    int? perPage = 10,
    int? employeeId,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      final idParam =
          employeeId != null ? "filter[employee_id]=$employeeId" : "";
      const roleParam = "filter[role]=user";

      final params = "$roleParam&$idParam&$pageParam&$perPageParam";
      final endpoint = "/v1/${role.getApiRoute}/users/customers?$params";
      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => CustomerModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> assignSubscriber(AssignSubscriberModel model) async {
    try {
      await dio.post("/v1/admin/subscriptions/assign", data: model.toJson());
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> addPoints(UserRoleEnum role, AddPointsModel model) async {
    try {
      final endpoint = "/v1/${role.getApiRoute}/points/add";
      await dio.post(endpoint, data: model.toJson());
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
  
  @override
  Future<void> assignMealPlan(AssignPlanModel model)async {
    try {
      final endpoint = "/v1/dietitian/meal-plans/assign";
      await dio.post(endpoint, data: model.toJson());
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
  
  @override
  Future<void> assignExercisePlan(AssignPlanModel model) async{
    try {
      final endpoint = "/v1/coach/execise-plans/assign";
      await dio.post(endpoint, data: model.toJson());
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
