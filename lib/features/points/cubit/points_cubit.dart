import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/points/model/add_points_guideline_model/add_points_guideline_model.dart';
import 'package:wellnesstrackerapp/features/points/model/points_guideline_model/fake_points_guideline.dart';
import 'package:wellnesstrackerapp/features/points/model/points_guideline_model/points_guideline_model.dart';
import 'package:wellnesstrackerapp/features/points/model/points_model/fake_points.dart';
import 'package:wellnesstrackerapp/features/points/model/points_model/points_model.dart';
import 'package:wellnesstrackerapp/features/points/service/points_service.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/activity_status_enum.dart';
import 'package:wellnesstrackerapp/global/models/en_ar_add_model/en_ar_add_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

part 'states/points_state.dart';
part 'states/general_points_state.dart';
part 'states/add_points_guildline_state.dart';
part 'states/points_guidelines_state.dart';

@injectable
class PointsCubit extends Cubit<GeneralPointsState> {
  PointsCubit(this.pointsService) : super(GeneralPointsInitial());
  final PointsService pointsService;

  AddPointsGuidelineModel model = const AddPointsGuidelineModel();
  EnArAddModel titleModel = const EnArAddModel();
  EnArAddModel descriptionModel = const EnArAddModel();

  void setModel(PointsGuidelineModel? model) {
    setTitleAr(model?.title.ar);
    setTitleEn(model?.title.en);
    setDescriptionAr(model?.description.ar);
    setDescriptionEn(model?.description.en);
    setLink(model?.link);
    if (model != null) {
      setIsActive(model.isActive
          ? ActivityStatusEnum.active
          : ActivityStatusEnum.inactive);
    }
  }

  void setTitleAr(String? title) {
    titleModel = titleModel.copyWith(ar: () => title);
    model = model.copyWith(title: () => titleModel);
  }

  void setTitleEn(String? title) {
    titleModel = titleModel.copyWith(en: () => title);
    model = model.copyWith(title: () => titleModel);
  }

  void setDescriptionEn(String? desc) {
    descriptionModel = descriptionModel.copyWith(en: () => desc);
    model = model.copyWith(description: () => descriptionModel);
  }

  void setDescriptionAr(String? desc) {
    descriptionModel = descriptionModel.copyWith(ar: () => desc);
    model = model.copyWith(description: () => descriptionModel);
  }

  void setLink(String? link) {
    model = model.copyWith(
      link: () => link,
    );
  }

  void setIsActive(ActivityStatusEnum isActive) {
    model = model.copyWith(isActive: isActive);
  }

  void resetModel() {
    model = const AddPointsGuidelineModel();
    titleModel = const EnArAddModel();
    descriptionModel = const EnArAddModel();
  }

  Future<void> getPoints() async {
    if (!get<UserRepo>().isSignedIn) {
      emit(PointsSuccess(fakePoints));
      return;
    }
    emit(PointsLoading());
    try {
      if (isClosed) return;
      final result = await pointsService.getPoints();
      emit(PointsSuccess(result));
    } catch (e) {
      if (isClosed) return;
      emit(PointsFail(e.toString()));
    }
  }

  Future<void> addPointsGuideLine({int? id}) async {
    emit(AddPointsGuidelineLoading());
    try {
      if (isClosed) return;
      await pointsService.addPointsGuideLine(model, id: id);
      final isAdd = id == null;
      final message = isAdd
          ? "points_guideline_added".tr()
          : "points_guideline_updated".tr();
      emit(AddPointsGuidelineSuccess(message));
    } catch (e) {
      if (isClosed) return;
      emit(AddPointsGuidelineFail(e.toString()));
    }
  }

  Future<void> getPointsGuideLines(
    UserRoleEnum role, {
    required int page,
    int perPage = 10,
  }) async {
    if (!get<UserRepo>().isSignedIn) {
      emit(PointsGuidelinesSuccess(fakePointsGuidelines, null));
      return;
    }
    emit(PointsGuidelinesLoading());
    try {
      if (isClosed) return;
      final result = await pointsService.getPointsGuideLines(
        role,
        page: page,
        perPage: perPage,
      );
      final message = result.data.isEmpty ? "no_points_guidelines".tr() : null;
      if (page == 1 && message != null) {
        emit(PointsGuidelinesEmpty(message));
      } else {
        emit(PointsGuidelinesSuccess(result, message));
      }
    } catch (e) {
      if (isClosed) return;
      emit(PointsGuidelinesFail(e.toString()));
    }
  }
}
