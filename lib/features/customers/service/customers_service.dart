import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/customers/model/add_points_model/add_points_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/assign_meal_plan_model/assign_meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/assign_subscriber_model/assign_subscriber_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
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
  Future<void> assignSubscriber(AssignSubscriberModel model);
  Future<void> addPoints(UserRoleEnum role,AddPointsModel model);
  Future<void> assignMealPlan(UserRoleEnum role,AssignMealPlanModel model);
}
