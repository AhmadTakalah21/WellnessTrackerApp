import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/ratings/model/rating_model/rating_model.dart';
import 'package:wellnesstrackerapp/features/ratings/service/ratings_service.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'states/ratings_state.dart';
part 'states/general_ratings_state.dart';

@injectable
class RatingsCubit extends Cubit<GeneralRatingsState> {
  RatingsCubit(this.ratingsService) : super(GeneralRatingsInitial());
  final RatingsService ratingsService;

  List<RatingModel> ratings = [];
  MetaModel? meta;

  String lastQuery = '';

  Future<void> getRatings({required int page, int perPage = 10}) async {
    emit(RatingsLoading());
    try {
      if (isClosed) return;
      final result =
          await ratingsService.getRatings(page: page, perPage: perPage);
      ratings = result.data;
      meta = result.meta;
      final message = result.data.isEmpty ? "no_ratings".tr() : null;
      if (page == 1 && result.data.isEmpty) {
        emit(RatingsEmpty("no_ratings".tr()));
      } else {
        emit(RatingsSuccess(result, message));
      }
    } catch (e) {
      if (isClosed) return;
      emit(RatingsFail(e.toString()));
    }
  }

  void searchRatings(String query) {
    lastQuery = query;

    final filtered = ratings.where((rating) {
      return rating.user.name.toLowerCase().contains(query.toLowerCase()) ||
          rating.comment.toLowerCase().contains(query.toLowerCase());
    }).toList();

    final meta = this.meta != null && query.isEmpty
        ? this.meta!
        : MetaModel(
            total: filtered.length,
            count: filtered.length,
            perPage: filtered.length,
            currentPage: 1,
            totalPages: 1,
          );

    final result = PaginatedModel<RatingModel>(data: filtered, meta: meta);
    emit(RatingsSuccess(result, filtered.isEmpty ? "no_ratings".tr() : null));
  }
}
