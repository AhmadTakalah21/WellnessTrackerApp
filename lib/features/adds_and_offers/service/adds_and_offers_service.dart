import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'adds_and_offers_service_imp.dart';

abstract class AddsAndOffersService {
  Future<PaginatedModel<AdvModel>> getAdvs({
    int perPage = 10,
    required int page,
  });
}
