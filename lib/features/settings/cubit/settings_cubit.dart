import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/settings/model/settings_model/settings_model.dart';
import 'package:wellnesstrackerapp/features/settings/model/update_settings_model/update_settings_model.dart';
import 'package:wellnesstrackerapp/features/settings/service/settings_service.dart';

part 'states/general_settings_state.dart';
part 'states/settings_state.dart';
part 'states/update_settings_state.dart';

@injectable
class SettingsCubit extends Cubit<GeneralSettingsState> {
  SettingsCubit(this.settingsService) : super(GeneralSettingsInitial());
  final SettingsService settingsService;

  UpdateSettingsModel updateSettingsModel = const UpdateSettingsModel();

  void setName(String? name) {
    updateSettingsModel = updateSettingsModel.copyWith(name: () => name);
  }

  void setAppUrlAndroid(String? url) {
    updateSettingsModel =
        updateSettingsModel.copyWith(appUrlAndroid: () => url);
  }

  void setAppUrlIos(String? url) {
    updateSettingsModel = updateSettingsModel.copyWith(appUrlIos: () => url);
  }

  void setEmail(String? email) {
    updateSettingsModel = updateSettingsModel.copyWith(email: () => email);
  }

  void setSupportPhoneNumber(String? phone) {
    updateSettingsModel =
        updateSettingsModel.copyWith(supportPhoneNumber: () => phone);
  }

  void resetUpdateModel() {
    updateSettingsModel = const UpdateSettingsModel();
  }

  Future<void> getSettings() async {
    emit(SettingsLoading());
    try {
      if (isClosed) return;
      final result = await settingsService.getSettings();
      emit(SettingsSuccess(result));
    } catch (e) {
      if (isClosed) return;
      emit(SettingsFail(e.toString()));
    }
  }

  Future<void> updateSettings() async {
    emit(UpdateSettingsLoading());
    try {
      if (isClosed) return;
      final response = await settingsService.updateSettings(
        updateSettingsModel,
      );
      final message = "info_updated".tr();
      emit(UpdateSettingsSuccess(response, message));
    } catch (e) {
      if (isClosed) return;
      emit(UpdateSettingsFail(e.toString()));
    }
  }
}
