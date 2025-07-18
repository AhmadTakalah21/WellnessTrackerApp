import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/add_adv_model/add_adv_model.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'adds_and_offers_service_imp.dart';

abstract class AddsAndOffersService {
  Future<PaginatedModel<AdvModel>> getAdvs(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  });
  Future<void> addAdv(AddAdvModel model, {XFile? image, int? id});
}
