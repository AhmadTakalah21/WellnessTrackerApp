import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'customers_service_imp.dart';

abstract class CustomersService {
  Future<PaginatedModel<CustomerModel>> getCustomers({
    int perPage = 10,
    required int page,
  });
}
