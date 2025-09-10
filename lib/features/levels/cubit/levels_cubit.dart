import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/levels/model/add_level_model/add_level_model.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/fake_levels.dart';

import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/features/levels/service/level_service.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

part 'states/levels_state.dart';
part 'states/add_level_state.dart';
part 'states/general_levels_state.dart';

@injectable
class LevelsCubit extends Cubit<GeneralLevelsState> {
  LevelsCubit(this.levelsService) : super(GeneralLevelsInitial());
  final LevelsService levelsService;

  List<LevelModel> _alllevels = [];
  MetaModel? meta;
  LevelModel? selectedLevel;

  AddLevelModel model = const AddLevelModel();
  XFile? image;

  DepartmentEnum? roleFilter;

  void setModel(LevelModel? level) {
    setName(level?.name);
    setDescription(level?.description);
    setType(level?.type);
  }

  void setName(String? name) {
    model = model.copyWith(name: () => name);
  }

  void setDescription(String? description) {
    model = model.copyWith(description: () => description);
  }

  void setType(DepartmentEnum? type) {
    model = model.copyWith(type: () => type);
  }

  void setImage(XFile? image) {
    this.image = image;
  }

  void resetModel() {
    model = const AddLevelModel();
    image = null;
  }

  void setRoleFilter(DepartmentEnum? role) {
    roleFilter = role;
    _applyFilters(_alllevels, role: role);
  }

  Future<void> getLevels(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
    if (!get<UserRepo>().isSignedIn) {
      emit(LevelsSuccess(fakeLevels, null));
      return;
    }
    emit(LevelsLoading());
    try {
      if (isClosed) return;
      final result = await levelsService.getLevels(
        role,
        page: page,
        perPage: perPage,
      );
      _alllevels = result.data;
      meta = result.meta;

      _applyFilters(_alllevels, role: roleFilter);
    } catch (e) {
      if (isClosed) return;
      emit(LevelsFail(e.toString()));
    }
  }

  List<LevelModel> _applyFilters(
    List<LevelModel> source, {
    DepartmentEnum? role,
  }) {
    final filtered = source.where((level) {
      final matchesRole = role == null || level.type.id == role.id;
      return matchesRole;
    }).toList();

    final meta = this.meta != null && role == null
        ? this.meta!
        : MetaModel(
            total: filtered.length,
            count: filtered.length,
            perPage: filtered.length,
            currentPage: 1,
            totalPages: 1,
          );

    final result = PaginatedModel<LevelModel>(data: filtered, meta: meta);

    if (filtered.isEmpty) {
      emit(LevelsEmpty("no_levels".tr()));
    } else {
      emit(LevelsSuccess(result, filtered.isEmpty ? "no_levels".tr() : null));
    }
    return filtered;
  }

  Future<void> addLevel({int? id}) async {
    emit(AddLevelLoading());
    try {
      final result = await levelsService.addLevel(model, image: image, id: id);
      final isAdd = id == null;
      final message = isAdd ? "level_added".tr() : "level_updated".tr();
      emit(AddLevelSuccess(result, message));
    } catch (e) {
      emit(AddLevelFail(e.toString()));
    }
  }
}
