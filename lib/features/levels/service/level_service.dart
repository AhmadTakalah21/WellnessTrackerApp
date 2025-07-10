import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'level_service_imp.dart';

abstract class LevelsService {
  Future<PaginatedModel<LevelModel>> getLevels({int? perPage = 10, int? page});
}
