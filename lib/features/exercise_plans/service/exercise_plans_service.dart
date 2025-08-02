import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/add_exercise_plan_model/add_exercise_plan_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_model/exercise_plan_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'exercise_plans_service_imp.dart';

abstract class ExercisePlansService {
  Future<PaginatedModel<ExercisePlanModel>> getExercisePlans(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  });

  Future<ExercisePlanModel> addExercisePlan(
    AddExercisePlanModel model, {
    int? id,
  });
}
