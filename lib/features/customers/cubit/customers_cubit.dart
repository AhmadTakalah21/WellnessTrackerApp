import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/customers/model/assign_subscriber_model/assign_subscriber_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/service/customers_service.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'states/customers_state.dart';
//part 'states/approve_customer_state.dart';
part 'states/general_customers_state.dart';
part 'states/assign_subscriber_state.dart';

@injectable
class CustomersCubit extends Cubit<GeneralCustomersState> {
  CustomersCubit(this.customerService) : super(GeneralCustomersInitial());
  final CustomersService customerService;

  List<CustomerModel> customers = [];
  MetaModel? meta;
  AssignSubscriberModel model = const AssignSubscriberModel();

  String lastQuery = '';
  String? lastStatus;
  String? lastDepartment;

  void setUserId(int? id) {
    model = model.copyWith(userId: () => id);
  }

  void setCoachId(int? id) {
    model = model.copyWith(coachId: () => id);
  }

  void setDoctorId(int? id) {
    model = model.copyWith(doctorId: () => id);
  }

  void setDietitianId(int? id) {
    model = model.copyWith(dietitianId: () => id);
  }

  void setLevelId(int? id) {
    model = model.copyWith(levelId: () => id);
  }

  void resetModel() {
    model = const AssignSubscriberModel();
  }

  Future<void> getCustomers(UserRoleEnum role,
    {int? page, int? perPage = 10}) async {
    emit(CustomersLoading());
    try {
      if (isClosed) return;
      final result = await customerService.getCustomers(
        role,
        page: page,
        perPage: perPage,
      );
      customers = result.data;
      meta = result.meta;
      final message = result.data.isEmpty ? "no_customers".tr() : null;
      emit(CustomersSuccess(result, message));
    } catch (e) {
      if (isClosed) return;
      emit(CustomersFail(e.toString()));
    }
  }

  void searchCodes(String query, {String? status, String? departmentName}) {
    lastQuery = query;
    lastStatus = status;
    lastDepartment = departmentName;

    final filtered = _applyFilters(customers, query, status, departmentName);

    final meta = this.meta != null &&
            (query.isEmpty && status == null && departmentName == null)
        ? this.meta!
        : MetaModel(
            total: filtered.length,
            count: filtered.length,
            perPage: filtered.length,
            currentPage: 1,
            totalPages: 1,
          );

    final result = PaginatedModel<CustomerModel>(data: filtered, meta: meta);

    final message = filtered.isEmpty ? "no_customers".tr() : null;
    emit(CustomersSuccess(result, message));
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

  Future<void> assignSubscriber() async {
    emit(AssignSubscriberLoading());
    try {
      if (isClosed) return;
      await customerService.assignSubscriber(model);
      emit(AssignSubscriberSuccess("subscriber_assigned_successfully".tr()));
    } catch (e) {
      if (isClosed) return;
      emit(AssignSubscriberFail(e.toString()));
    }
  }
}
