import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/meals/model/add_meal_model/add_meal_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'meals_service_imp.dart';

abstract class MealsService {
  Future<PaginatedModel<MealModel>> getMeals({
    int? perPage = 10,
    int? page,
  });

  Future<MealModel> addMeal(AddMealModel model, {int? id});
}
