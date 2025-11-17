import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/customers/model/add_medical_consultation_model/add_medical_consultation_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/add_points_model/add_points_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/assign_meal_plan_model/assign_meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/assign_subscribers_model/assign_subscribers_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_evaluation_model/customer_evaluation_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/evaluate_customer_model/evaluate_customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/update_customer_info_model/update_customer_info_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'customers_service_imp.dart';

abstract class CustomersService {
  Future<PaginatedModel<CustomerModel>> getCustomers(
    UserRoleEnum role, {
    int? page,
    int? perPage = 10,
    int? employeeId,
  });
  // Future<void> assignSubscriber(AssignSubscriberModel model);
  Future<void> assignSubscriber(AssignSubscribersModel model);

  Future<void> changeStatus(int id, String status);
  Future<void> updateCustomerInfo(
    UserRoleEnum role,
    UpdateCustomerInfoModel model,
    int id,
  );
  Future<void> addPoints(UserRoleEnum role, AddPointsModel model);
  Future<void> assignMealPlan(AssignPlanModel model);
  Future<void> assignExercisePlan(AssignPlanModel model);
  Future<void> evaluateSubscriber(
    UserRoleEnum role,
    int id,
    EvaluateCustomerModel model,
  );
  Future<CustomerEvaluationModel> getSubscriberEvaluation(
    UserRoleEnum role,
    int id,
  );
  Future<void> addMedicalConsultation(
    UserRoleEnum role,
    int id,
    AddMedicalConsultationModel model,
  );
}
