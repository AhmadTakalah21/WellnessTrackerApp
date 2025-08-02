import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/customers/model/add_points_model/add_points_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/assign_meal_plan_model/assign_meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/assign_subscriber_model/assign_subscriber_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/service/customers_service.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'states/customers_state.dart';
part 'states/general_customers_state.dart';
part 'states/assign_subscriber_state.dart';
part 'states/assign_meal_plan_state.dart';
//part 'states/assign_exercise_plan_state.dart';
part 'states/add_points_state.dart';

@injectable
class CustomersCubit extends Cubit<GeneralCustomersState> {
  CustomersCubit(this.customerService) : super(GeneralCustomersInitial());
  final CustomersService customerService;

  List<CustomerModel> customers = [];
  MetaModel? meta;
  AssignSubscriberModel model = const AssignSubscriberModel();
  AddPointsModel addPointsModel = const AddPointsModel();
  AssignPlanModel assignPlanModel = const AssignPlanModel();
  List<int> userIds = [];

  UserModel? selectedDietitian;
  UserModel? selectedCoach;
  UserModel? selectedDoctor;

  String lastQuery = '';
  String? lastStatus;
  String? lastDepartment;

  void setUserId(int? id) {
    model = model.copyWith(userId: () => id);
  }

  void setEmployeeId(UserModel? user) {
    if (user != null) {
      if (user.role.isCoach) {
        model = model.copyWith(coachId: () => user.id);
        selectedCoach = user;
      } else if (user.role.isDietitian) {
        model = model.copyWith(dietitianId: () => user.id);
        selectedDietitian = user;
      } else if (user.role.isDoctor) {
        model = model.copyWith(doctorId: () => user.id);
        selectedDoctor = user;
      } else {
        return;
      }
      emit(SelectedSpecialistsState(
        selectedDietitian,
        selectedCoach,
        selectedDoctor,
      ));
    }
  }

  void setLevelId(int? id) {
    model = model.copyWith(levelId: () => id);
  }

  void setPoints(String? points) {
    addPointsModel = addPointsModel.copyWith(points: () => points);
  }

  bool isSelected(CustomerModel customer) {
    return userIds.any((id) => customer.id == id);
  }

  void updateUserIds(CustomerModel customer) {
    final exists = userIds.any((id) => customer.id == id);
    if (!exists) {
      userIds.add(customer.id);
    } else {
      userIds.remove(customer.id);
    }
  }

  void setPlanId(int? planId) {
    assignPlanModel = assignPlanModel.copyWith(planId: () => planId);
  }

  void clearUserIds() => userIds.clear();

  void resetAddPointsModel() {
    addPointsModel = const AddPointsModel();
  }

  void resetAssignSubscriberModel() {
    selectedDietitian = null;
    selectedCoach = null;
    selectedDoctor = null;
    emit(SelectedSpecialistsState(
      selectedDietitian,
      selectedCoach,
      selectedDoctor,
    ));
    model = const AssignSubscriberModel();
  }

  void resetAssignPlanModel() {
    assignPlanModel = const AssignPlanModel();
  }

  Future<void> getCustomers(
    UserRoleEnum role, {
    int? page,
    int? perPage = 10,
    int? employeeId,
  }) async {
    emit(CustomersLoading());
    try {
      if (isClosed) return;
      final result = await customerService.getCustomers(role,
          page: page, perPage: perPage, employeeId: employeeId);
      customers = result.data;
      meta = result.meta;
      final message = result.data.isEmpty ? "no_customers".tr() : null;
      if (page == 1 && result.data.isEmpty) {
        emit(CustomersEmpty("no_customers".tr()));
      } else {
        emit(CustomersSuccess(result, message));
      }
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
    print(model.coachId);
    print(model.dietitianId);
    print(model.doctorId);
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

  Future<void> addPoints(UserRoleEnum role) async {
    addPointsModel = addPointsModel.copyWith(subscribers: () => userIds);
    emit(AddPointsLoading());
    try {
      if (isClosed) return;
      await customerService.addPoints(role, addPointsModel);
      emit(AddPointsSuccess("points_added".tr()));
    } catch (e) {
      if (isClosed) return;
      emit(AddPointsFail(e.toString()));
    }
  }

  Future<void> assignMealPlan() async {
    assignPlanModel = assignPlanModel.copyWith(users: () => userIds);
    emit(AssignPlanLoading());
    try {
      if (isClosed) return;
      await customerService.assignMealPlan(assignPlanModel);
      emit(AssignPlanSuccess("meal_plan_assigned".tr()));
    } catch (e) {
      if (isClosed) return;
      emit(AssignPlanFail(e.toString()));
    }
  }

  Future<void> assignExercisePlan() async {
    assignPlanModel = assignPlanModel.copyWith(users: () => userIds);
    emit(AssignPlanLoading());
    try {
      if (isClosed) return;
      await customerService.assignExercisePlan(assignPlanModel);
      emit(AssignPlanSuccess("exercise_plan_assigned".tr()));
    } catch (e) {
      if (isClosed) return;
      emit(AssignPlanFail(e.toString()));
    }
  }
}
