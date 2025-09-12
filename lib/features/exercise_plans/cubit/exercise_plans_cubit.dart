import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/add_exercise_plan_model/add_exercise_plan_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_day_item_model/exercise_plan_day_item_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_day_item_model/exercise_plan_day_item_to_show_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_day_model/exercise_plan_day_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_model/exercise_plan_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_model/fake_exercise_plans.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/service/exercise_plans_service.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

part 'states/general_exercise_plans_state.dart';
part 'states/exercise_plans_state.dart';
part 'states/add_exercise_plan_state.dart';

@injectable
class ExercisePlansCubit extends Cubit<GeneralExercisePlansState> {
  ExercisePlansCubit(this.exercisePlanService)
      : super(GeneralExercisePlansInitial());
  final ExercisePlansService exercisePlanService;

  List<ExercisePlanModel> _allExercisePlans = [];
  MetaModel? meta;

  AddExercisePlanModel model = const AddExercisePlanModel();
  List<ExerciseModel> selectedExercises = [];
  List<ExercisePlanDayItemToShowModel> planDays = DayEnum.values
      .map((day) => ExercisePlanDayItemToShowModel(day: day, exercises: []))
      .toList();

  void setModel(ExercisePlanModel? plan) {
    setName(plan?.name);
    for (var planDay in plan?.planDays ?? <ExercisePlanDayModel>[]) {
      setExercisesForDay(planDay.exercises);
      setExercisesForDayForModel(planDay.day);
    }
  }

  void setName(String? name) {
    model = model.copyWith(name: () => name);
  }

  void setExercisesForDay(List<ExerciseModel> exercises) {
    selectedExercises = exercises;
  }

  void setExercisesForDayForModel(DayEnum day) {
    final index = planDays.indexWhere((plan) => day.id == plan.day.id);
    planDays[index] = planDays[index].copyWith(exercises: selectedExercises);
    emit(PlanDaysState(planDays));
  }

  void setPlanDays() {
    model = model.copyWith(
      planDays: () => planDays.map((e) {
        final exercises = e.exercises.map((e2) => e2.id).toList();
        return ExercisePlanDayItemModel(day: e.day, exercises: exercises);
      }).toList(),
    );
  }

  void getPlanDays() {
    emit(PlanDaysState(planDays));
  }

  void resetModel() {
    model = const AddExercisePlanModel();
    for (var planDay in planDays) {
      planDay.exercises.clear();
    }
    selectedExercises.clear();
  }

  Future<void> getExercisePlans(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
    if (!get<UserRepo>().isSignedIn) {
      emit(ExercisePlansLoading());
      Future.delayed(Duration(microseconds: 1), () {
        emit(ExercisePlansSuccess(fakeExercisePlans, null));
      });
      return;
    }
    emit(ExercisePlansLoading());
    try {
      if (isClosed) return;

      final result = await exercisePlanService.getExercisePlans(
        role,
        page: page,
        perPage: perPage,
      );

      _allExercisePlans = result.data;
      meta = result.meta;

      if (_allExercisePlans.isEmpty) {
        emit(ExercisePlansEmpty("no_exercise_plans".tr()));
      } else {
        emit(ExercisePlansSuccess(result, null));
      }
    } catch (e) {
      if (isClosed) return;
      emit(ExercisePlansFail(e.toString()));
    }
  }

  Future<void> addExercisePlan({int? id}) async {
    setPlanDays();
    emit(AddExercisePlanLoading());
    try {
      final result = await exercisePlanService.addExercisePlan(model, id: id);
      final isAdd = id == null;
      final message =
          isAdd ? "exercise_plan_added".tr() : "exercise_plan_updated".tr();
      emit(AddExercisePlanSuccess(result, message));
    } catch (e) {
      emit(AddExercisePlanFail(e.toString()));
    }
  }
}
