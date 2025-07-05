part of 'customers_service.dart';

@Injectable(as: CustomersService)
class CustomersServiceImp implements CustomersService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<CustomerModel>> getCustomers({
    int perPage = 10,
    required int page,
  }) async {
    try {
      final perPageParam = "per_page=$perPage";
      final pageParam = "page=$page";
      const roleParam = "filter[role]=user";
      final endpoint =
          "/v1/admin/users/customers?$roleParam&$pageParam&$perPageParam";
      final response = await dio.get(endpoint);
      return PaginatedModel.fromJson(
        response.data as Map<String, dynamic>,
        (json) => CustomerModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }
}
