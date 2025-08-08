import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/points/model/add_points_guideline_model/add_points_guideline_model.dart';
import 'package:wellnesstrackerapp/features/points/model/points_guideline_model/points_guideline_model.dart';
import 'package:wellnesstrackerapp/features/points/model/points_model/points_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part "points_service_imp.dart";

abstract class PointsService {
  Future<PointsModel> getPoints();
  Future<PaginatedModel<PointsGuidelineModel>> getPointsGuideLines(
    UserRoleEnum role, {
    int perPage = 10,
    required int page,
  });
  Future<void> addPointsGuideLine(AddPointsGuidelineModel model, {int? id});
}
