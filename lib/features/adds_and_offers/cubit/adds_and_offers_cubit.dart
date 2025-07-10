import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/add_adv_model/add_adv_model.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/service/adds_and_offers_service.dart';
import 'package:wellnesstrackerapp/global/models/adv_type_enum.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'states/adds_and_offers_state.dart';
part 'states/general_adds_and_offers_state.dart';
part 'states/add_adv_state.dart';

@injectable
class AddsAndOffersCubit extends Cubit<GeneralAddsAndOffersState> {
  AddsAndOffersCubit(this.addsAndOffersService)
      : super(GeneralAddsAndOffersInitial());
  final AddsAndOffersService addsAndOffersService;

  AddAdvModel model = const AddAdvModel();
  XFile? image;

  void setTitleEn(String? value) {
    model = model.copyWith(titleEn: () => value);
  }

  void setTitleAr(String? value) {
    model = model.copyWith(titleAr: () => value);
  }

  void setDescriptionEn(String? value) {
    model = model.copyWith(descriptionEn: () => value);
  }

  void setDescriptionAr(String? value) {
    model = model.copyWith(descriptionAr: () => value);
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
  }

  Future<void> getAddsAndOffers({int? perPage = 10, int? page}) async {
    emit(AddsAndOffersLoading());
    try {
      final result = await addsAndOffersService.getAdvs(
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
      emit(AddsAndOffersFail(e.toString()));
    }
  }

  Future<void> addAdv({required bool isAdd, int? id}) async {
    emit(AddAdvLoading());
    try {
      if (isClosed) return;
      await addsAndOffersService.addAdv(
        model,
        isAdd: isAdd,
        id: id,
        image: image,
      );
      emit(AddAdvSuccess("ad_added_successfully".tr()));
    } catch (e) {
      if (isClosed) return;
      emit(AddAdvFail(e.toString()));
    }
  }
}
