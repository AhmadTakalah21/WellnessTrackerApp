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
        (json) {
          CustomerModel customer =
              CustomerModel.fromJson(json as Map<String, dynamic>);
          customer = customer.copyWith(
            isForEmployee: employeeId != null,
            requestRole: role,
          );
          return customer;
        },
      );
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  // Future<void> assignSubscriber(AssignSubscriberModel model) async {
  Future<void> assignSubscriber(AssignSubscribersModel model) async {
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
  Future<void> assignMealPlan(AssignPlanModel model) async {
    try {
      final endpoint = "/v1/dietitian/meal-plans/assign";
      await dio.post(endpoint, data: model.toJson());
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> assignExercisePlan(AssignPlanModel model) async {
    try {
      final endpoint = "/v1/coach/exercise-plans/assign";
      await dio.post(endpoint, data: model.toJson());
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateCustomerInfo(
    UserRoleEnum role,
    UpdateCustomerInfoModel model,
    int id,
  ) async {
    try {
      final endpoint = "/v1/${role.getApiRoute}/subscribers/$id";
      final data = model.toJson();
      data.addAll({"_method": "PUT"});
      await dio.post(endpoint, data: data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> changeStatus(int id, String status) async {
    try {
      final endpoint = "/v1/admin/subscriptions/change-status/$id";
      await dio.post(endpoint, data: {"status": status});
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> evaluateSubscriber(
    UserRoleEnum role,
    int id,
    EvaluateCustomerModel model,
  ) async {
    try {
      final endpoint = "/v1/${role.getApiRoute}/subscriptions/evaluate/$id";
      await dio.post(endpoint, data: model.toJson());
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<CustomerEvaluationModel> getSubscriberEvaluation(
    UserRoleEnum role,
    int id,
  ) async {
    try {
      final endpoint = "/v1/${role.getApiRoute}/subscriptions/evaluate/$id";
      final response = await dio.get(endpoint);
      final data = response.data["data"] as Map<String, dynamic>;
      return CustomerEvaluationModel.fromJson(data);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> addMedicalConsultation(
    UserRoleEnum role,
    int id,
    AddMedicalConsultationModel model,
  ) async {
    try {
      final endpoint = "/v1/${role.getApiRoute}/consultations/$id";
      await dio.post(endpoint, data: model.toJson());
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

}
