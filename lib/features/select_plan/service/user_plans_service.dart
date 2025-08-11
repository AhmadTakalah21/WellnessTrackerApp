import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/select_plan/model/user_plan_model/user_plan_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';

part 'user_plans_service_imp.dart';

abstract class UserPlansService {
  Future<List<UserPlanModel>> getPlans();
}
