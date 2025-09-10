import 'package:wellnesstrackerapp/features/select_plan/model/user_plan_model/user_plan_model.dart';
import 'package:wellnesstrackerapp/features/select_plan/model/user_plans_model/user_plans_model.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';

final fakeUserPlans = UserPlansModel(
  plans: [
    UserPlanModel(
      department: DepartmentEnum.dietitian,
      phone: "+91756756756",
    )
  ],
  emergenciesPhone: "+91756756756",
);
