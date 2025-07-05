import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/service/adds_and_offers_service.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'states/adds_and_offers_state.dart';
part 'states/general_adds_and_offers_state.dart';

@injectable
class AddsAndOffersCubit extends Cubit<GeneralAddsAndOffersState> {
  AddsAndOffersCubit(this.addsAndOffersService)
      : super(GeneralAddsAndOffersInitial());
  final AddsAndOffersService addsAndOffersService;

  Future<void> getAddsAndOffersS({required int page, int perPage = 10}) async {
    emit(AddsAndOffersLoading());
    try {
      final result = await addsAndOffersService.getAdvs(
        page: page,
        perPage: perPage,
      );
      final message = result.data.isEmpty ? "no_adds_and_offers".tr() : null;
      emit(AddsAndOffersSuccess(result, message));
    } catch (e) {
      emit(AddsAndOffersFail(e.toString()));
    }
  }
}
