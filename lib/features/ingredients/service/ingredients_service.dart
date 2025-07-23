import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/add_ingredient_model/add_ingredient_model.dart';
import 'package:wellnesstrackerapp/features/ingredients/model/ingredient_model/ingredient_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'ingredients_service_imp.dart';

abstract class IngredientsService {
  Future<PaginatedModel<IngredientModel>> getIngredients({
    int? perPage = 10,
    int? page,
  });

  Future<IngredientModel> addIngredient(AddIngredientModel model, {int? id});
}
