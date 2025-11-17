import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/add_meal_plan_model/add_meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/fake_meal_plans.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_item_model/plan_day_item_to_show_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_model/plan_day_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/service/meal_plans_service.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

import '../model/plan_day_item_model/plan_day_item_model.dart';

part 'states/general_meal_plans_state.dart';
part 'states/meal_plans_state.dart';
part 'states/add_meal_plan_state.dart';

@injectable
class MealPlansCubit extends Cubit<GeneralMealPlansState> {
  MealPlansCubit(this.mealPlanService) : super(GeneralMealPlansInitial());
  final MealPlansService mealPlanService;

  List<MealPlanModel> _allMealPlans = [];
  MetaModel? meta;

  AddMealPlanModel model = const AddMealPlanModel();
  List<MealModel> selectedMeals = [];
  List<PlanDayItemToShowModel> planDays = DayEnum.values
      .map((day) => PlanDayItemToShowModel(day: day, meals: []))
      .toList();

  Future<void> setModel(MealPlanModel? plan) async {
    setName(plan?.name);
    for (var planDay in plan?.planDays ?? <PlanDayModel>[]) {
      setMealsForDay(planDay.meals);
      setMealsForDayForModel(planDay.day);
    }
  }

  void setName(String? name) {
    model = model.copyWith(name: () => name);
  }

  void setMealsForDay(List<MealModel> meals) {
    selectedMeals = meals;
  }

  void setMealsForDayForModel(DayEnum day) {
    final index = planDays.indexWhere((plan) => day.id == plan.day.id);
    planDays[index] = planDays[index].copyWith(meals: selectedMeals);
    emit(MealPlanDaysState(planDays));
  }

  void setPlanDays() {
    model = model.copyWith(
        planDays: () => planDays.map((plan) {
              final meals = plan.meals.map((meal) => meal.id).toList();
              return PlanDayItemModel(day: plan.day, meals: meals);
            }).toList());
  }

  void getPlanDays() {
    emit(MealPlanDaysState(planDays));
  }

  void resetModel() {
    model = const AddMealPlanModel();
    planDays = DayEnum.values
        .map((day) => PlanDayItemToShowModel(day: day, meals: []))
        .toList();
    selectedMeals.clear();
  }

  Future<void> getMealPlans(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
    if (!get<UserRepo>().isSignedIn) {
      emit(MealPlansLoading());
      Future.delayed(Duration(microseconds: 1), () {
        emit(MealPlansSuccess(fakeMealPlans, null));
      });
      return;
    }
    emit(MealPlansLoading());
    try {
      if (isClosed) return;

      final result = await mealPlanService.getMealPlans(
        role,
        page: page,
        perPage: perPage,
      );

      _allMealPlans = result.data;
      meta = result.meta;

      if (_allMealPlans.isEmpty) {
        emit(MealPlansEmpty("no_meal_plans".tr()));
      } else {
        emit(MealPlansSuccess(result, null));
      }
    } catch (e) {
      if (isClosed) return;
      emit(MealPlansFail(e.toString()));
    }
  }

  Future<void> addMealPlan({int? id}) async {
    setPlanDays();
    emit(AddMealPlanLoading());
    try {
      final result = await mealPlanService.addMealPlan(model, id: id);
      final isAdd = id == null;
      final message = isAdd ? "meal_plan_added".tr() : "meal_plan_updated".tr();
      emit(AddMealPlanSuccess(result, message));
    } catch (e) {
      emit(AddMealPlanFail(e.toString()));
    }
  }
}
