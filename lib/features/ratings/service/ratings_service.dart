import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/ratings/model/rating_model/rating_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'ratings_service_imp.dart';

abstract class RatingsService {
  Future<PaginatedModel<RatingModel>> getRatings({
    int perPage = 10,
    required int page,
  });
}
