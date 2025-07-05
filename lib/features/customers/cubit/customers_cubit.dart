import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/service/customers_service.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'states/customers_state.dart';
part 'states/approve_customer_state.dart';
part 'states/general_customers_state.dart';

@injectable
class CustomersCubit extends Cubit<GeneralCustomersState> {
  CustomersCubit(this.customerService) : super(GeneralCustomersInitial());
  final CustomersService customerService;

  List<CustomerModel> customers = [];

  String lastQuery = '';
  String? lastStatus;
  String? lastDepartment;

  Future<void> getCustomers({required int page, int perPage = 10}) async {
    emit(CustomersLoading());
    try {
      final result = await customerService.getCustomers(
        page: page,
        perPage: perPage,
      );
      customers = result.data;
      final message = result.data.isEmpty ? "no_customers".tr() : null;
      emit(CustomersSuccess(result, message));
    } catch (e) {
      emit(CustomersFail(e.toString()));
    }
  }

  void searchCodes(String query, {String? status, String? departmentName}) {
    lastQuery = query;
    lastStatus = status;
    lastDepartment = departmentName;

    final filtered = _applyFilters(customers, query, status, departmentName);
    final result = PaginatedModel<CustomerModel>(
      data: filtered,
      meta: MetaModel(
        total: filtered.length,
        count: filtered.length,
        perPage: filtered.length,
        currentPage: 1,
        totalPages: 1,
      ),
    );

    emit(CustomersSuccess(
        result, filtered.isEmpty ? "no_customers".tr() : null));
  }

  List<CustomerModel> _applyFilters(List<CustomerModel> source, String query,
      String? status, String? department) {
    return source.where((customer) {
      final matchesQuery =
          customer.name.toLowerCase().contains(query.toLowerCase());
      final matchesStatus = status == null ||
          customer.status.toLowerCase() == status.toLowerCase();
      return matchesQuery && matchesStatus;
    }).toList();
  }
}
