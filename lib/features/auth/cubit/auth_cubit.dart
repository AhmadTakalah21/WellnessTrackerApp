import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellnesstrackerapp/features/auth/model/add_info_model/add_info_model.dart';
import 'package:wellnesstrackerapp/features/auth/model/post_sign_up_model/post_sign_up_model.dart';
import 'package:wellnesstrackerapp/features/auth/model/reset_password_post_model/reset_password_post_model.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/features/auth/service/auth_service.dart';
import 'package:wellnesstrackerapp/features/auth_manager/bloc/auth_manager_bloc.dart';
import 'package:wellnesstrackerapp/global/dio/exceptions.dart';
import 'package:wellnesstrackerapp/global/models/gender_enum.dart';

part 'states/auth_state.dart';
part 'states/text_field_state.dart';
part 'states/sign_in_state.dart';
part 'states/add_info_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo, this.authManagerBloc) : super(AuthInitial());
  final AuthService authRepo;
  final AuthManagerBloc? authManagerBloc;

  PostSignUpModel postSignUpModel = const PostSignUpModel();
  ResetPasswordPostModel resetPasswordPostModel =
      const ResetPasswordPostModel();
  AddInfoModel addInfoModel = const AddInfoModel();

  void setUsername(String username) {
    postSignUpModel = postSignUpModel.copyWith(username: () => username);
    emit(TextFieldState(TextFieldType.username));
  }

  void setEmail(String email) {
    postSignUpModel = postSignUpModel.copyWith(email: () => email);
    emit(TextFieldState(TextFieldType.email));
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

  void setSubscriptionCode(String code) {
    postSignUpModel = postSignUpModel.copyWith(code: () => code);
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

  void setGender(GenderEnum? gender) {
    addInfoModel = addInfoModel.copyWith(gender: () => gender);
  }

  void setBirthday(String? birthday) {
    addInfoModel = addInfoModel.copyWith(birthday: () => birthday);
  }

  void setAge(String? age) {
    addInfoModel = addInfoModel.copyWith(age: () => age);
  }

  void setWeight(String? weight) {
    addInfoModel = addInfoModel.copyWith(weight: () => weight);
  }

  void setLength(String? length) {
    addInfoModel = addInfoModel.copyWith(length: () => length);
  }

  void setChronicDiseases(String? value) {
    addInfoModel = addInfoModel.copyWith(chronicDiseases: () => value);
  }

  void setWaistCircumference(String? value) {
    addInfoModel = addInfoModel.copyWith(waistCircumference: () => value);
  }

  void setChest(String? value) {
    addInfoModel = addInfoModel.copyWith(chest: () => value);
  }

  void setShoulder(String? value) {
    addInfoModel = addInfoModel.copyWith(shoulder: () => value);
  }

  void setThighCircumference(String? value) {
    addInfoModel = addInfoModel.copyWith(thighCircumference: () => value);
  }

  void setForearmCircumference(String? value) {
    addInfoModel = addInfoModel.copyWith(forearmCircumference: () => value);
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
        fcmToken,
      );
      emit(SignInSuccess(response, "login_success".tr()));
      authManagerBloc?.add(SignInRequested(response, onSuccess: onSuccess));
    } catch (e) {
      emit(SignInFail(e.toString()));
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

  Future<void> resetPassword() async {
    bool shouldReturn = false;

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
      emit(
        TextFieldState(
          TextFieldType.confirmPassword,
          error: confirmPasswordError,
        ),
      );
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.confirmPassword));
    }
    if (shouldReturn) return;
    try {
      // TODO
    } catch (e) {}
  }

  Future<void> forgetPassword() async {
    bool shouldReturn = false;

    final emailError = postSignUpModel.validateEmail();
    if (emailError != null) {
      emit(TextFieldState(TextFieldType.email, error: emailError));
      shouldReturn = true;
    } else {
      emit(TextFieldState(TextFieldType.email));
    }
    if (shouldReturn) return;
    try {
      // TODO
    } catch (e) {}
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
}
