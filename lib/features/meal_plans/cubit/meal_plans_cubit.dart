import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/add_meal_plan_model/add_meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_item_model/plan_day_item_to_show_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_model/plan_day_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/service/meal_plans_service.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

import '../../../global/models/day_enum.dart';
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
  List<PlanDayItemToShowModel> planDays = List.generate(
    DayEnum.values.length,
    (index) {
      final day = DayEnum.values[index];
      return PlanDayItemToShowModel(day: day, meals: []);
    },
  );

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
        planDays: () => planDays.map((e) {
              final meals = e.meals.map((e2) => e2.id).toList();
              return PlanDayItemModel(day: e.day, meals: meals);
            }).toList());
  }

  void getPlanDays() {
    emit(MealPlanDaysState(planDays));
  }

  void resetModel() {
    model = const AddMealPlanModel();
    for (var planDay in planDays) {
      planDay.meals.clear();
    }
    selectedMeals.clear();
  }

  Future<void> getMealPlans(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
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
