import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/features/levels/service/level_service.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'states/levels_state.dart';
part 'states/general_levels_state.dart';

@injectable
class LevelsCubit extends Cubit<GeneralLevelsState> {
  LevelsCubit(this.levelsService) : super(GeneralLevelsInitial());
  final LevelsService levelsService;

  List<LevelModel> levels = [];
  MetaModel? meta;
  LevelModel? selectedLevel;

  Future<void> getLevels({int? perPage = 10, int? page}) async {
    emit(LevelsLoading());
    try {
      final result = await levelsService.getLevels(
        page: page,
        perPage: perPage,
      );
      levels = result.data;
      meta = result.meta;
      emit(
          LevelsSuccess(result, result.data.isEmpty ? "no_levels".tr() : null));
    } catch (e) {
      emit(LevelsFail(e.toString()));
    }
  }
}
