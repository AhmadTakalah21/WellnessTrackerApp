import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/add_meal_plan_model/add_meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/service/meal_plans_service.dart';
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
  MealPlanModel? selectedMealPlan;

  AddMealPlanModel model = const AddMealPlanModel();

  /// Contains the selected meals per day like: { "monday": [1, 3, 7], "tuesday": [] }
  final Map<String, List<int>> selectedMealsByDay = {};

  void setName(String? name) {
    model = model.copyWith(name: () => name);
  }

  /// Set selected meals (IDs) for a specific day (e.g., "monday")
  void setMealsForDay(String day, List<int> mealIds) {
    selectedMealsByDay[day] = mealIds;
  }

  /// Prepare the detailed plan days before saving
  void setDetailedPlanDays() {
    final planDays = selectedMealsByDay.entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) => PlanDayItemModel(
      day: DayEnum.values.firstWhere((d) => d.name == entry.key),
      meals: entry.value,
    ))
        .toList();

    model = model.copyWith(planDays: () => planDays);
  }

  void resetModel() {
    model = const AddMealPlanModel();
    selectedMealsByDay.clear();
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
    emit(AddMealPlanLoading());
    try {
      final result = await mealPlanService.addMealPlan(model, id: id);
      final isAdd = id == null;
      final message =
      isAdd ? "meal_plan_added".tr() : "meal_plan_updated".tr();
      emit(AddMealPlanSuccess(result, message));
    } catch (e) {
      emit(AddMealPlanFail(e.toString()));
    }
  }
}
