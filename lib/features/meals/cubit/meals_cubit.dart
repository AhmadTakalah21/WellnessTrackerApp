import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_item_model/ingredient_item_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_item_model/ingregient_item_to_show_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/ingredient_with_quantity_model/ingredient_with_quantity_model.dart';

import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/add_meal_model/add_meal_model.dart';
import 'package:wellnesstrackerapp/features/meals/service/meals_service.dart';
import 'package:wellnesstrackerapp/global/models/meal_type_enum.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'states/meals_state.dart';
part 'states/add_meal_state.dart';
part 'states/general_meals_state.dart';

@injectable
class MealsCubit extends Cubit<GeneralMealsState> {
  MealsCubit(this.mealService) : super(GeneralMealsInitial());

  final MealsService mealService;

  List<MealModel> _allMeals = [];
  MetaModel? meta;

  AddMealModel model = const AddMealModel();
  List<IngredientItemToShowModel> ingredients = [];
  String? filePath;

  void setModel(MealModel? meal) {
    setName(meal?.name);
    setDescription(meal?.description);
    setType(meal?.type);
    setLink(meal?.link);
    setIngredientsToModel(
      meal?.ingredients
              .map((e) =>
                  IngredientItemModel(ingredientId: e.id, quantity: e.quantity))
              .toList() ??
          [],
    );
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

  void setFile(String? filePath) {
    this.filePath = filePath;
    model = model.copyWith(file: () => filePath);
  }

  void setLink(String? link) {
    model = model.copyWith(link: () => link);
  }

  // void updateQuantityForIngredient(bool isAdd, int index) {
  //   int quantity = ingredients[index].quantity;
  //   if (isAdd) {
  //     quantity++;
  //   } else {
  //     if (quantity != 0) {
  //       quantity--;
  //     }
  //   }
  //   ingredients[index] = ingredients[index].copyWith(quantity: quantity);
  // }

  void updateQuantityForIngredient(int quantity, int index) {
    ingredients[index] = ingredients[index].copyWith(quantity: quantity);
    emit(SelectedIngredientsState(ingredients));
  }

  void setIngredientsInitial(List<IngredientWithQuantityModel> items) {
    final initialItems = items.map((e) => e.ingredient).toList();
    final newIds = initialItems.map((e) => e.id).toSet();
    ingredients =
        ingredients.where((e) => newIds.contains(e.ingredient.id)).toList();
    for (final item in items) {
      final exists =
          ingredients.any((e) => e.ingredient.id == item.ingredient.id);
      if (!exists) {
        ingredients.add(IngredientItemToShowModel(
            ingredient: item.ingredient, quantity: item.quantity));
      }
    }
    emit(SelectedIngredientsState(ingredients));
  }

  void setIngredients(List<IngredientModel> items) {
    final newIds = items.map((e) => e.id).toSet();
    ingredients =
        ingredients.where((e) => newIds.contains(e.ingredient.id)).toList();
    for (final item in items) {
      final exists = ingredients.any((e) => e.ingredient.id == item.id);
      if (!exists) {
        ingredients
            .add(IngredientItemToShowModel(ingredient: item, quantity: 0));
      }
    }
    emit(SelectedIngredientsState(ingredients));
  }

  void setIngredientsToModel(List<IngredientItemModel> items) {
    model = model.copyWith(ingredients: () => items);
  }

  void resetModel() {
    filePath = null;
    ingredients.clear();
    model = const AddMealModel();
  }

  Future<void> getMeals({int? perPage = 10, int? page}) async {
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
    setIngredientsToModel(ingredients
        .map((e) => IngredientItemModel(
              ingredientId: e.ingredient.id,
              quantity: e.quantity,
            ))
        .toList());
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
}
