import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/add_ingredient_model/add_ingredient_model.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';
import 'package:wellnesstrackerapp/features/ingredients/service/ingredients_service.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_with_quantity_model/ingredient_with_quantity_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/models/ingredient_unit_enum.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'states/ingredients_state.dart';
part 'states/add_ingredient_state.dart';
part 'states/general_ingredients_state.dart';

@injectable
class IngredientsCubit extends Cubit<GeneralIngredientsState> {
  IngredientsCubit(this.ingredientService) : super(GeneralIngredientsInitial());

  final IngredientsService ingredientService;

  List<IngredientModel> _allIngredients = [];
  MetaModel? meta;
  IngredientModel? selectedIngredient;

  AddIngredientModel model = const AddIngredientModel();

  void setModel(IngredientModel? ingredient) {
    setName(ingredient?.name);
    setUnit(ingredient?.unit);
    setCalories(ingredient?.calories);
    setCarbs(ingredient?.carbs);
    setProteins(ingredient?.proteins);
  }

  void setName(String? name) {
    model = model.copyWith(name: () => name);
  }

  void setUnit(IngredientUnitEnum? unit) {
    model = model.copyWith(unit: () => unit);
  }

  void setCalories(String? calories) {
    model = model.copyWith(calories: () => calories);
  }

  void setCarbs(String? carbs) {
    model = model.copyWith(carbs: () => carbs);
  }

  void setProteins(String? proteins) {
    model = model.copyWith(proteins: () => proteins);
  }

  void resetModel() {
    model = const AddIngredientModel();
  }

  Future<void> getIngredients(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
    MealModel? meal,
  }) async {
    emit(IngredientsLoading());
    try {
      if (isClosed) return;
      final result = await ingredientService.getIngredients(
        page: page,
        perPage: perPage,
      );
      _allIngredients = result.data;
      meta = result.meta;

      if (_allIngredients.isEmpty) {
        emit(IngredientsEmpty("no_ingredients".tr()));
      } else {
        List<IngredientWithQuantityModel>? mealIngredientsInResult;

        if (meal != null) {
          mealIngredientsInResult = [];
          for (var ingredient in meal.ingredients) {
            final selected = result.data.firstWhere(
              (element) => ingredient.ingredient.id == element.id,
            );
            mealIngredientsInResult.add(IngredientWithQuantityModel(
              id: 1,
              quantity: ingredient.quantity,
              ingredient: selected,
            ));
          }
        }

        emit(IngredientsSuccess(result, mealIngredientsInResult, null));
      }
    } catch (e) {
      if (isClosed) return;
      emit(IngredientsFail(e.toString()));
    }
  }

  Future<void> addIngredient({int? id}) async {
    emit(AddIngredientLoading());
    try {
      final result = await ingredientService.addIngredient(model, id: id);
      final isAdd = id == null;
      final message =
          isAdd ? "ingredient_added".tr() : "ingredient_updated".tr();
      emit(AddIngredientSuccess(result, message));
    } catch (e) {
      emit(AddIngredientFail(e.toString()));
    }
  }
}
