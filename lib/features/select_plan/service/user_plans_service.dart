import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/select_plan/model/user_plans_model/user_plans_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';

part 'user_plans_service_imp.dart';

abstract class UserPlansService {
  Future<UserPlansModel> getPlans();
}
