import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/add_adv_model/add_adv_model.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/fake_advs.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/service/adds_and_offers_service.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/adv_type_enum.dart';
import 'package:wellnesstrackerapp/global/models/en_ar_add_model/en_ar_add_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

part 'states/adds_and_offers_state.dart';
part 'states/general_adds_and_offers_state.dart';
part 'states/add_adv_state.dart';

@injectable
class AddsAndOffersCubit extends Cubit<GeneralAddsAndOffersState> {
  AddsAndOffersCubit(this.addsAndOffersService)
      : super(GeneralAddsAndOffersInitial());
  final AddsAndOffersService addsAndOffersService;
  EnArAddModel advTitle = const EnArAddModel();
  EnArAddModel advDescription = const EnArAddModel();

  AddAdvModel model = const AddAdvModel();
  XFile? image;

  void setTitleEn(String? title) {
    advTitle = advTitle.copyWith(en: () => title);
    model = model.copyWith(title: () => advTitle);
  }

  void setTitleAr(String? title) {
    advTitle = advTitle.copyWith(ar: () => title);
    model = model.copyWith(title: () => advTitle);
  }

  void setDescriptionEn(String? description) {
    advDescription = advDescription.copyWith(en: () => description);
    model = model.copyWith(description: () => advDescription);
  }

  void setDescriptionAr(String? description) {
    advDescription = advDescription.copyWith(ar: () => description);
    model = model.copyWith(description: () => advDescription);
  }

  void setEndDate(String? value) {
    model = model.copyWith(endDate: () => value);
  }

  void setType(AdvTypeEnum? type) {
    model = model.copyWith(type: () => type);
  }

  void setImage(XFile? image) {
    this.image = image;
  }

  void resetModel() {
    model = const AddAdvModel();
    setImage(null);
  }

  Future<void> getAddsAndOffers(
    UserRoleEnum role, {
    int? perPage = 10,
    int? page,
  }) async {
    if (!get<UserRepo>().isSignedIn) {
      emit(AddsAndOffersSuccess(fakeAdvs, null));
      return;
    }
    emit(AddsAndOffersLoading());
    try {
      if (isClosed) return;
      final result = await addsAndOffersService.getAdvs(
        role,
        page: page,
        perPage: perPage,
      );
      final advs = result.data.where((adv) => adv.type.isAdv);
      final offers = result.data.where((adv) => !adv.type.isAdv);
      final isBothEmpty = advs.isEmpty && offers.isEmpty;
      final message = isBothEmpty ? "no_adds_and_offers".tr() : null;
      if (isBothEmpty) {
        emit(AddsAndOffersEmpty(message!));
      } else {
        emit(AddsAndOffersSuccess(result, message));
      }
    } catch (e) {
      if (isClosed) return;
      emit(AddsAndOffersFail(e.toString()));
    }
  }

  Future<void> addAdv({int? id}) async {
    final image = this.image;
    if (image == null) {
      emit(AddAdvFail("image_required".tr()));
      return;
    }
    emit(AddAdvLoading());
    try {
      if (isClosed) return;
      await addsAndOffersService.addAdv(model, id: id, image: image);
      final isAdd = id == null;
      final message = isAdd ? "added".tr() : "updated".tr();
      emit(AddAdvSuccess(message));
    } catch (e) {
      if (isClosed) return;
      emit(AddAdvFail(e.toString()));
    }
  }
}
