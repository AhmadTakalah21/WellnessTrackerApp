import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/add_meal_plan_model/add_meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/meal_plan_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'meal_plans_service_imp.dart';

abstract class MealPlansService {
  Future<PaginatedModel<MealPlanModel>> getMealPlans(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  });

  Future<MealPlanModel> addMealPlan(AddMealPlanModel model, {int? id});
}
