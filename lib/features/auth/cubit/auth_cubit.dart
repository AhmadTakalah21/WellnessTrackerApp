import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellnesstrackerapp/features/auth/model/add_info_model/add_info_model.dart';
import 'package:wellnesstrackerapp/features/auth/model/post_sign_up_model/post_sign_up_model.dart';
import 'package:wellnesstrackerapp/features/auth/model/reset_password_post_model/reset_password_post_model.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/features/auth/service/auth_service.dart';
import 'package:wellnesstrackerapp/features/auth_manager/bloc/auth_manager_bloc.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/dio/exceptions.dart';
import 'package:wellnesstrackerapp/global/models/gender_enum.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

part 'states/auth_state.dart';
part 'states/text_field_state.dart';
part 'states/sign_in_state.dart';
part 'states/add_info_state.dart';
part 'states/subscription_expired_state.dart';
part 'states/forget_password_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo, this.authManagerBloc) : super(AuthInitial());
  final AuthService authRepo;
  final AuthManagerBloc? authManagerBloc;

  PostSignUpModel postSignUpModel = const PostSignUpModel();
  ResetPasswordPostModel resetPasswordPostModel =
      const ResetPasswordPostModel();
  AddInfoModel addInfoModel = const AddInfoModel();
  String? code;
  String? resetCode;

  void setUsername(String username) {
    postSignUpModel = postSignUpModel.copyWith(username: () => username);
    emit(TextFieldState(TextFieldType.username));
  }

  void setEmail(String email) {
    postSignUpModel = postSignUpModel.copyWith(email: () => email);
    emit(TextFieldState(TextFieldType.email));
  }

  void setPhone(PhoneNumber? phone) {
    postSignUpModel =
        postSignUpModel.copyWith(phoneNumber: () => phone?.completeNumber);
    emit(TextFieldState(TextFieldType.phone));
  }

  void setPassword(String password) {
    postSignUpModel = postSignUpModel.copyWith(password: () => password);
    emit(TextFieldState(TextFieldType.password));
  }

  void setConfirmPassword(String confirmPassword) {
    postSignUpModel = postSignUpModel.copyWith(
      confirmPassword: () => confirmPassword,
    );
    emit(TextFieldState(TextFieldType.confirmPassword));
  }

  void setSubscriptionCode(String? code) {
    postSignUpModel = postSignUpModel.copyWith(code: () => code);
    this.code = code;
    emit(TextFieldState(TextFieldType.code));
  }

  void setNewPassword(String password) {
    resetPasswordPostModel = resetPasswordPostModel.copyWith(
      password: () => password,
    );
    emit(TextFieldState(TextFieldType.password));
  }

  void setConfirmNewPassword(String confirmPassword) {
    resetPasswordPostModel = resetPasswordPostModel.copyWith(
      confirmPassword: () => confirmPassword,
    );
    emit(TextFieldState(TextFieldType.confirmPassword));
  }

  void setResetCode(String code) {
    resetCode = code.trim();
    emit(TextFieldState(TextFieldType.code));
  }

  void setInitialFormData() {
    setGender(GenderEnum.male);
    setWeight(50);
    setLength(160);
  }

  void setGender(GenderEnum? gender) {
    addInfoModel = addInfoModel.copyWith(gender: () => gender);
  }

  void setBirthday(String? birthday) {
    addInfoModel = addInfoModel.copyWith(birthday: () => birthday);
  }

  void setWeight(int weight) {
    addInfoModel = addInfoModel.copyWith(weight: () => weight.toString());
  }

  void setLength(int length) {
    addInfoModel = addInfoModel.copyWith(length: () => length.toString());
  }

  void setChronicDiseases(String? value) {
    addInfoModel = addInfoModel.copyWith(chronicDiseases: () => value);
  }

  void setWaistCircumference(int value) {
    addInfoModel =
        addInfoModel.copyWith(waistCircumference: () => value.toString());
  }

  void setChest(int value) {
    addInfoModel = addInfoModel.copyWith(chest: () => value.toString());
  }

  void setShoulder(int value) {
    addInfoModel = addInfoModel.copyWith(shoulder: () => value.toString());
  }

  void setThighCircumference(int value) {
    addInfoModel =
        addInfoModel.copyWith(thighCircumference: () => value.toString());
  }

  void setForearmCircumference(int value) {
    addInfoModel =
        addInfoModel.copyWith(forearmCircumference: () => value.toString());
  }

  void resetAddInfoModel() {
    addInfoModel = const AddInfoModel();
  }

  Future<void> signIn({VoidCallback? onSuccess}) async {
    bool shouldReturn = false;

    final emailError = postSignUpModel.validateEmail();
    if (emailError != null) {
      emit(TextFieldState(TextFieldType.email, error: emailError));
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.email));
    }

    final passwordError = postSignUpModel.validatePassword();
    if (passwordError != null) {
      emit(TextFieldState(TextFieldType.password, error: passwordError));
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.password));
    }

    if (shouldReturn) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final fcmToken = prefs.getString("fcm_token");
    postSignUpModel = postSignUpModel.copyWith(fcmToken: () => fcmToken);

    emit(SignInLoading());

    try {
      final response = await authRepo.signIn(
        postSignUpModel.email,
        postSignUpModel.password,
        code: code,
        fcmToken,
      );
      emit(SignInSuccess(response, "login_success".tr()));
      authManagerBloc?.add(SignInRequested(response, onSuccess: onSuccess));
    } catch (e) {
      emit(SignInFail(e.toString()));
      if (e.toString().contains("your_subscription_has_expired".tr())) {
        emit(SubscriptionExpiredState());
      }
    }
  }

  Future<void> signUp({VoidCallback? onSuccess}) async {
    bool shouldReturn = false;

    final usernameError = postSignUpModel.validateUsername();
    if (usernameError != null) {
      emit(TextFieldState(TextFieldType.username, error: usernameError));
      shouldReturn = true;
    }

    final emailError = postSignUpModel.validateEmail();
    if (emailError != null) {
      emit(TextFieldState(TextFieldType.email, error: emailError));
      shouldReturn = true;
    }

    if (get<UserRepo>().isV1) {
      final phoneError = postSignUpModel.validatePhoneNumber();
      if (phoneError != null) {
        emit(TextFieldState(TextFieldType.phone, error: phoneError));
        shouldReturn = true;
      }
    }

    final passwordError = postSignUpModel.validatePassword();
    if (passwordError != null) {
      emit(TextFieldState(TextFieldType.password, error: passwordError));
      shouldReturn = true;
    }

    final confirmPasswordError = postSignUpModel.validateConfirmPassword();
    if (confirmPasswordError != null) {
      emit(TextFieldState(TextFieldType.confirmPassword,
          error: confirmPasswordError));
      shouldReturn = true;
    }

    final codeError = postSignUpModel.validateCode();
    if (codeError != null) {
      emit(TextFieldState(TextFieldType.code, error: codeError));
      shouldReturn = true;
    }

    if (shouldReturn) return;

    final prefs = await SharedPreferences.getInstance();
    final fcmToken = prefs.getString("fcm_token");
    postSignUpModel = postSignUpModel.copyWith(fcmToken: () => fcmToken);

    emit(SignInLoading());

    try {
      final response = await authRepo.signUp(postSignUpModel);
      emit(SignUpSuccess(response, "signup_success".tr()));
      authManagerBloc?.add(
        SignInRequested(
          response,
          isSignIn: false,
          onSuccess: onSuccess,
        ),
      );
      // authManagerBloc?.add(SignUpRequested(response, onSuccess: onSuccess));
    } catch (e) {
      emit(SignInFail(e.toString()));
    }
  }

  Future<void> logout({VoidCallback? onSuccess}) async {
    emit(SignInLoading());

    try {
      await authRepo.logout();
      emit(LogOutSuccess("logout_success".tr()));
      authManagerBloc?.add(SignOutRequested());
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(LogOutSuccess("logout_success".tr()));
        authManagerBloc?.add(SignOutRequested());
      } else {
        emit(SignInFail(e.toString()));
      }
    }
  }

  Future<void> addInfo() async {
    emit(AddInfoLoading());
    try {
      await authRepo.addInfo(addInfoModel);
      emit(AddInfoSuccess("info_added".tr()));
      authManagerBloc?.add(ProfileFormCompletedRequested());
    } catch (e) {
      emit(AddInfoFail(e.toString()));
    }
  }

  Future<void> sendResetCode() async {
    bool shouldReturn = false;

    final emailError = postSignUpModel.validateEmail();
    if (emailError != null) {
      emit(TextFieldState(TextFieldType.email, error: emailError));
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.email));
    }
    if (shouldReturn) return;

    emit(ForgotPasswordLoading());
    try {
      await authRepo.requestPasswordReset(email: postSignUpModel.email.trim());
      emit(ForgotPasswordSuccess("reset_code_sent".tr()));
    } catch (e) {
      emit(ForgotPasswordFail(e.toString()));
    }
  }

  Future<void> verifyResetCode() async {
    bool shouldReturn = false;

    final emailError = postSignUpModel.validateEmail();
    if (emailError != null) {
      emit(TextFieldState(TextFieldType.email, error: emailError));
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.email));
    }

    if (resetCode == null || resetCode!.isEmpty) {
      emit(TextFieldState(TextFieldType.code, error: "required_field".tr()));
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.code));
    }

    if (shouldReturn) return;

    emit(VerifyResetCodeLoading());
    try {
      await authRepo.verifyPasswordResetCode(
        email: postSignUpModel.email.trim(),
        code: resetCode!.trim(),
      );
      emit(VerifyResetCodeSuccess("reset_code_verified".tr()));
    } catch (e) {
      emit(VerifyResetCodeFail(e.toString()));
    }
  }

  Future<void> resetPassword() async {
    bool shouldReturn = false;

    final emailError = postSignUpModel.validateEmail();
    if (emailError != null) {
      emit(TextFieldState(TextFieldType.email, error: emailError));
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.email));
    }

    if (resetCode == null || resetCode!.isEmpty) {
      emit(TextFieldState(TextFieldType.code, error: "required_field".tr()));
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.code));
    }

    final passwordError = resetPasswordPostModel.validatePassword();
    if (passwordError != null) {
      emit(TextFieldState(TextFieldType.password, error: passwordError));
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.password));
    }

    final confirmPasswordError =
        resetPasswordPostModel.validateConfirmPassword();
    if (confirmPasswordError != null) {
      emit(TextFieldState(TextFieldType.confirmPassword,
          error: confirmPasswordError));
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.confirmPassword));
    }

    if (shouldReturn) return;

    emit(ResetPasswordLoading());
    try {
      await authRepo.resetPassword(
        email: postSignUpModel.email.trim(),
        code: resetCode!.trim(),
        password: resetPasswordPostModel.password,
        passwordConfirmation: resetPasswordPostModel.confirmPassword!,
      );

      emit(ResetPasswordSuccess("password_reset_success".tr()));
      resetCode = null;
      resetPasswordPostModel = const ResetPasswordPostModel();
    } catch (e) {
      emit(ResetPasswordFail(e.toString()));
    }
  }
}
