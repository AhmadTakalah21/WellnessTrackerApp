import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/levels/model/add_level_model/add_level_model.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'level_service_imp.dart';

abstract class LevelsService {
  Future<PaginatedModel<LevelModel>> getLevels(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  });
  Future<LevelModel> addLevel(
    AddLevelModel model, {
    required bool isAdd,
    XFile? image,
    int? id,
  });
}
