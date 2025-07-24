import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/add_meal_model/add_meal_model.dart';
import 'package:wellnesstrackerapp/features/meals/service/meals_service.dart';
import 'package:wellnesstrackerapp/global/models/meal_type_enum.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'states/meals_state.dart';
part 'states/add_meal_state.dart';
part 'states/general_meals_state.dart';

@injectable
class MealsCubit extends Cubit<GeneralMealsState> {
  MealsCubit(this.mealService) : super(GeneralMealsInitial());

  final MealsService mealService;

  List<MealModel> _allMeals = [];
  MetaModel? meta;
  MealModel? selectedMeal;

  AddMealModel model = const AddMealModel();

  void setModel(MealModel? meal) {
    setName(meal?.name);
    setDescription(meal?.description);
    setType(meal?.type);
    setLink(meal?.link);
    setIngredients(meal?.ingredients);
  }

  void setName(String? name) {
    model = model.copyWith(name: () => name);
  }

  void setDescription(String? description) {
    model = model.copyWith(description: () => description);
  }

  void setType(MealTypeEnum? type) {
    model = model.copyWith(type: () => type);
  }

  void setLink(String? link) {
    model = model.copyWith(link: () => link);
  }

  void setIngredients(List? list) {
    model = model.copyWith(ingredients: () => list?.cast());
  }

  void resetModel() {
    model = const AddMealModel();
  }

  Future<void> getMeals(
      UserRoleEnum role, {
        int? perPage = 10,
        int? page,
      }) async {
    emit(MealsLoading());
    try {
      if (isClosed) return;
      final result = await mealService.getMeals(
        page: page,
        perPage: perPage,
      );
      _allMeals = result.data;
      meta = result.meta;

      if (_allMeals.isEmpty) {
        emit(MealsEmpty("no_meals".tr()));
      } else {
        emit(MealsSuccess(result, null));
      }
    } catch (e) {
      if (isClosed) return;
      emit(MealsFail(e.toString()));
    }
  }

  Future<void> addMeal({int? id}) async {
    emit(AddMealLoading());
    try {
      final result = await mealService.addMeal(model, id: id);
      final isAdd = id == null;
      final message = isAdd ? "meal_added".tr() : "meal_updated".tr();
      emit(AddMealSuccess(result, message));
    } catch (e) {
      emit(AddMealFail(e.toString()));
    }
  }

  /// ✅ دالة جديدة: جلب جميع الوجبات دفعة واحدة (لاستخدامها في التخطيط)
  Future<List<MealModel>> getAllMeals() async {
    try {
      final result = await mealService.getMeals(page: 1, perPage: 1000);
      _allMeals = result.data;
      return _allMeals;
    } catch (e) {
      return [];
    }
  }
}
