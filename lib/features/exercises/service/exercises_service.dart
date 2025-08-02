import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/exercises/model/add_exercise_model/add_exercise_model.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'exercises_service_imp.dart';

abstract class ExercisesService {
  Future<PaginatedModel<ExerciseModel>> getExercises({
    int? perPage = 10,
    int? page,
  });

  Future<ExerciseModel> addExercise(AddExerciseModel model, {int? id});
}
