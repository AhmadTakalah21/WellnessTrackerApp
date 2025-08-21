import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/ratings/model/rating_model/rating_model.dart';
import 'package:wellnesstrackerapp/features/ratings/service/ratings_service.dart';

part 'states/ratings_state.dart';
part 'states/general_ratings_state.dart';

@injectable
class RatingsCubit extends Cubit<GeneralRatingsState> {
  RatingsCubit(this.ratingsService) : super(GeneralRatingsInitial());
  final RatingsService ratingsService;

  List<RatingModel> ratings = [];
  int page = 1;
  bool hasMore = true;

  String lastQuery = '';

  Future<void> getRatings({int perPage = 10, bool isLoadMore = true}) async {
    if (!hasMore && isLoadMore) {
      emit(RatingsSuccess(ratings, hasMore: false));
      return;
    }
    if (!isLoadMore) {
      page = 1;
      hasMore = true;
      ratings.clear();
    }
    if (ratings.isEmpty) {
      emit(RatingsLoading());
    } else {
      emit(RatingsSuccess(ratings, isLoadingMore: true));
    }

    try {
      if (isClosed) return;
      final newItems = await ratingsService.getRatings(
        page: page,
        perPage: perPage,
      );

      if (newItems.meta.count == newItems.meta.total) {
        hasMore = false;
      }
      if (newItems.data.isEmpty) {
        hasMore = false;
        if (page == 1) {
          emit(RatingsEmpty("no_ratings".tr()));
        }
      } else {
        ratings.addAll(newItems.data);
        page++;
      }

      ratings = newItems.data;
      if (ratings.isEmpty) {
        emit(RatingsEmpty("no_ratings".tr()));
      } else {
        emit(RatingsSuccess(ratings));
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
    emit(RatingsSuccess(filtered,));
  }
}
