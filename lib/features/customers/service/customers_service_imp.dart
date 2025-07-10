part of 'customers_service.dart';

@Injectable(as: CustomersService)
class CustomersServiceImp implements CustomersService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<CustomerModel>> getCustomers({
    int? page,
    int? perPage = 10,
  }) async {
    try {
      final perPageParam = perPage != null ? "per_page=$perPage" : "";
      final pageParam = page != null ? "page=$page" : "";
      const roleParam = "filter[role]=user";
      final endpoint =
          "/v1/admin/users/customers?$roleParam&$pageParam&$perPageParam";
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
}
