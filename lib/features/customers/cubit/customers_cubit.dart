import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/customers/model/add_medical_consultation_model/add_medical_consultation_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/add_points_model/add_points_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/assign_meal_plan_model/assign_meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/assign_subscriber_model/assign_subscriber_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_evaluation_model/customer_evaluation_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_info_model/customer_info_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/evaluate_customer_model/evaluate_customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/update_customer_info_model/update_customer_info_model.dart';
import 'package:wellnesstrackerapp/features/customers/service/customers_service.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/global/models/activity_status_enum.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'states/customers_state.dart';
part 'states/general_customers_state.dart';
part 'states/assign_subscriber_state.dart';
part 'states/assign_meal_plan_state.dart';
//part 'states/assign_exercise_plan_state.dart';
part 'states/add_points_state.dart';
part 'states/add_medical_consultation_state.dart';
part 'states/update_customer_info_state.dart';
part 'states/evaluate_subscriber_state.dart';
part 'states/subscriber_evaluation_state.dart';

@injectable
class CustomersCubit extends Cubit<GeneralCustomersState> {
  CustomersCubit(this.customerService) : super(GeneralCustomersInitial());
  final CustomersService customerService;

  List<CustomerModel> customers = [];
  MetaModel? meta;
  UpdateCustomerInfoModel updateCustomerInfoModel =
      const UpdateCustomerInfoModel();
  AssignSubscriberModel model = const AssignSubscriberModel();
  AddPointsModel addPointsModel = const AddPointsModel();
  AssignPlanModel assignPlanModel = const AssignPlanModel();
  EvaluateCustomerModel evaluateCustomerModel = const EvaluateCustomerModel();
  AddMedicalConsultationModel addMedicalConsultationModel =
      const AddMedicalConsultationModel();

  List<int> userIds = [];

  UserModel? selectedDietitian;
  UserModel? selectedCoach;
  UserModel? selectedDoctor;
  UserModel? selectedPsychologist;

  ActivityStatusEnum? status;

  String lastQuery = '';
  String? lastStatus;
  String? lastDepartment;

  void setUserId(int? id) {
    model = model.copyWith(userId: () => id);
  }

  void setInitailCustomerInfo(CustomerInfoModel info) {
    setWeight(info.weight);
    setLength(info.length);
    setChronicDiseases(info.chronicDiseases);
    setWaistCircumference(info.waistCircumference);
    setChest(info.chest);
    setShoulder(info.shoulder);
  }

  void setWeight(int weight) {
    updateCustomerInfoModel =
        updateCustomerInfoModel.copyWith(weight: () => weight.toString());
  }

  void setLength(int length) {
    updateCustomerInfoModel =
        updateCustomerInfoModel.copyWith(length: () => length.toString());
  }

  void setChronicDiseases(String? value) {
    updateCustomerInfoModel =
        updateCustomerInfoModel.copyWith(chronicDiseases: () => value);
  }

  void setWaistCircumference(int? value) {
    updateCustomerInfoModel = updateCustomerInfoModel.copyWith(
        waistCircumference: () => value.toString());
  }

  void setChest(int? value) {
    updateCustomerInfoModel =
        updateCustomerInfoModel.copyWith(chest: () => value.toString());
  }

  void setShoulder(int? value) {
    updateCustomerInfoModel =
        updateCustomerInfoModel.copyWith(shoulder: () => value.toString());
  }

  void setEmployeeId(UserModel? user) {
    if (user != null) {
      if (user.role.isCoach) {
        selectedCoach = selectedCoach != user ? user : null;
        model = model.copyWith(coachId: () => selectedCoach?.id);
      } else if (user.role.isDietitian) {
        selectedDietitian = selectedDietitian != user ? user : null;
        model = model.copyWith(dietitianId: () => selectedDietitian?.id);
      } else if (user.role.isDoctor) {
        selectedDoctor = selectedDoctor != user ? user : null;
        model = model.copyWith(doctorId: () => selectedDoctor?.id);
      } else if (user.role.isPsychologist) {
        selectedPsychologist = selectedPsychologist != user ? user : null;
        model = model.copyWith(psychologistId: () => selectedPsychologist?.id);
      } else {
        return;
      }
      emit(SelectedSpecialistsState(
        selectedDietitian,
        selectedCoach,
        selectedDoctor,
        selectedPsychologist,
      ));
    }
  }

  void setActivityStatus(ActivityStatusEnum? status) {
    this.status = status;
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

  void setHealth(String? health) {
    evaluateCustomerModel =
        evaluateCustomerModel.copyWith(health: () => health);
  }

  void setPsychology(String? psychology) {
    evaluateCustomerModel =
        evaluateCustomerModel.copyWith(psychology: () => psychology);
  }

  void setBehavior(String? behavior) {
    evaluateCustomerModel =
        evaluateCustomerModel.copyWith(behavior: () => behavior);
  }

  void setPlansCount(int? plansCount) {
    evaluateCustomerModel =
        evaluateCustomerModel.copyWith(plansCount: () => plansCount);
  }

  void setMedicalConsultation(String? medicalConsultation) {
    addMedicalConsultationModel = addMedicalConsultationModel.copyWith(
      medicalConsultation: () => medicalConsultation,
    );
  }

  void clearUserIds() => userIds.clear();

  void resetAddPointsModel() {
    addPointsModel = const AddPointsModel();
  }

  void resetEvaluateCustomerModel() {
    evaluateCustomerModel = const EvaluateCustomerModel();
  }

  void resetAddMedicalConsultationModel() {
    addMedicalConsultationModel = const AddMedicalConsultationModel();
  }

  void resetAssignSubscriberModel() {
    selectedDietitian = null;
    selectedCoach = null;
    selectedDoctor = null;
    selectedPsychologist = null;
    status = null;
    emit(SelectedSpecialistsState(
      selectedDietitian,
      selectedCoach,
      selectedDoctor,
      selectedPsychologist,
    ));
    model = const AssignSubscriberModel();
  }

  void resetAssignPlanModel() {
    assignPlanModel = const AssignPlanModel();
  }

  void resetUpdateCustomerInfoModel() {
    updateCustomerInfoModel = const UpdateCustomerInfoModel();
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
      if ((page == 1 || page == null) && result.data.isEmpty) {
        emit(CustomersEmpty("no_customers".tr()));
      } else {
        emit(CustomersSuccess(result, message));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CustomersFail(e.toString()));
    }
  }

  void searchCustomers(String query, {String? status, String? departmentName}) {
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

  Future<void> updateCustomerInfo(UserRoleEnum role, int id) async {
    emit(UpdateCustomerInfoLoading());
    try {
      if (isClosed) return;
      await customerService.updateCustomerInfo(
        role,
        updateCustomerInfoModel,
        id,
      );
      emit(UpdateCustomerInfoSuccess("info_updated_successfully".tr()));
    } catch (e) {
      if (isClosed) return;
      emit(UpdateCustomerInfoFail(e.toString()));
    }
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

  Future<void> changeStatus(int id) async {
    if (status == null) {
      emit(AssignSubscriberFail("status_required".tr()));
      return;
    }
    emit(AssignSubscriberLoading());
    try {
      if (isClosed) return;
      await customerService.changeStatus(id, status!.name);
      emit(AssignSubscriberSuccess("status_updated".tr()));
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

  Future<void> evaluateSubscriber(UserRoleEnum role, int id) async {
    emit(EvaluateSubscriberLoading());
    try {
      if (isClosed) return;
      await customerService.evaluateSubscriber(role, id, evaluateCustomerModel);
      emit(EvaluateSubscriberSuccess("subscriber_evaluated".tr()));
    } catch (e) {
      if (isClosed) return;
      emit(EvaluateSubscriberFail(e.toString()));
    }
  }

  Future<void> getSubscriberEvaluation(UserRoleEnum role, int id) async {
    emit(SubscriberEvaluationLoading());
    try {
      if (isClosed) return;
      final evaluation =
          await customerService.getSubscriberEvaluation(role, id);
      emit(SubscriberEvaluationSuccess(evaluation));
    } catch (e) {
      if (isClosed) return;
      emit(SubscriberEvaluationFail(e.toString()));
    }
  }

  Future<void> addMedicalConsultation(UserRoleEnum role, int id) async {
    emit(AddMedicalConsultationLoading());
    try {
      if (isClosed) return;
      await customerService.addMedicalConsultation(
        role,
        id,
        addMedicalConsultationModel,
      );
      emit(AddMedicalConsultationSuccess("medical_consultation_added".tr()));
    } catch (e) {
      if (isClosed) return;
      emit(AddMedicalConsultationFail(e.toString()));
    }
  }
}
