import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/fake_customer.dart';
import 'package:wellnesstrackerapp/features/profile/model/update_profile_model/update_profile_model.dart';
import 'package:wellnesstrackerapp/features/profile/service/profile_service.dart';
import 'package:wellnesstrackerapp/features/ratings/model/add_rate_model/add_rate_model.dart';
import 'package:wellnesstrackerapp/features/ratings/model/rating_model/rating_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

part 'states/profile_state.dart';
part 'states/general_profile_state.dart';
part 'states/add_rating_state.dart';
part 'states/update_profile_state.dart';

@injectable
class ProfileCubit extends Cubit<GeneralProfileState> {
  ProfileCubit(this.profileService) : super(GeneralProfileInitial());
  final ProfileService profileService;
  AddRateModel addRateModel = const AddRateModel();
  UpdateProfileModel updateProfileModel = const UpdateProfileModel();
  XFile? image;

  setUpdateProfileModel(CustomerModel? customer) {
    setName(customer?.name);
    setPhone(customer?.phone);
  }

  void setRating(int? rating) {
    addRateModel = addRateModel.copyWith(rating: () => rating);
  }

  void setComment(String? comment) {
    addRateModel = addRateModel.copyWith(comment: () => comment);
  }

  void setName(String? name) {
    updateProfileModel = updateProfileModel.copyWith(name: () => name);
  }

  void setPhone(String? phone) {
    updateProfileModel = updateProfileModel.copyWith(phone: () => phone);
  }

  void setImage(XFile? image) {
    this.image = image;
  }

  void resetAddRateModel() {
    addRateModel = const AddRateModel();
  }

  Future<void> addRating({int? id}) async {
    if (!get<UserRepo>().isSignedIn) return;
    emit(AddRatingLoading());
    try {
      if (isClosed) return;
      final response = await profileService.addRating(addRateModel, id: id);
      final isAdd = id == null;
      final message = isAdd ? "rating_added".tr() : "rating_updated".tr();
      emit(AddRatingSuccess(response, message));
    } catch (e) {
      if (isClosed) return;
      emit(AddRatingFail(e.toString()));
    }
  }

  Future<void> getProfile() async {
    if (!get<UserRepo>().isSignedIn) {
      emit(ProfileSuccess(fakeCustomer));
      return;
    }
    emit(ProfileLoading());
    try {
      if (isClosed) return;
      final response = await profileService.getProfile();
      emit(ProfileSuccess(response));
    } catch (e) {
      if (isClosed) return;
      emit(ProfileFail(e.toString()));
    }
  }

  Future<void> updateProfile() async {
    if (!get<UserRepo>().isSignedIn) return;
    emit(UpdateProfileLoading());
    try {
      if (isClosed) return;
      final response = await profileService.updateProfile(
        updateProfileModel,
        image: image,
      );
      emit(UpdateProfileSuccess(response,"profile_updated".tr()));
      await getProfile();
    } catch (e) {
      if (isClosed) return;
      emit(UpdateProfileFail(e.toString()));
    }
  }
}
