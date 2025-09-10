import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

part 'auth_manager_event.dart';
part 'auth_manager_state.dart';

@singleton
class AuthManagerBloc extends Bloc<AuthManagerEvent, GeneralAuthManagerState> {
  AuthManagerBloc(this._userRepo) : super(InitialAuthManagerState()) {
    on<IsAuthenticatedOrFirstTime>(_findIfAuthenticatedOrFirstTime);
    on<OnBoardingViewedRequested>(_goToLogIn);
    on<SignInRequested>(_signIn);
    on<GuestRequested>(_continueAsGuest);
    on<ProfileFormCompletedRequested>(_completeProfileForm);
    on<SignOutRequested>(_signOut);
  }

  final UserRepo _userRepo;

  Future<void> _findIfAuthenticatedOrFirstTime(
    IsAuthenticatedOrFirstTime event,
    Emitter<GeneralAuthManagerState> emit,
  ) async {
    final firstTime = await _userRepo.getKey(firstTimeKey, defaultValue: true);
    final profileForm =
        await _userRepo.getKey(profileFormKey, defaultValue: true);
    if (firstTime) {
      emit(FirstTimeState());
    } else {
      if (_userRepo.user != null) {
        if (profileForm) {
          emit(ProfileFormState());
        } else {
          emit(AuthenticatedState(_userRepo.user!));
        }
      } else {
        emit(UnauthenticatedState());
      }
    }
  }

  Future<void> _goToLogIn(
    OnBoardingViewedRequested event,
    Emitter<GeneralAuthManagerState> emit,
  ) async {
    _userRepo.setKey(firstTimeKey, false);
    emit(UnauthenticatedState());
  }

  Future<void> _signIn(
    SignInRequested event,
    Emitter<GeneralAuthManagerState> emit,
  ) async {
    await _userRepo.setUser(event.signInModel);
    _userRepo.setKey(profileFormKey, !event.isSignIn);
    event.onSuccess?.call();
    if (!event.isSignIn) {
      emit(ProfileFormState());
    } else {
      emit(AuthenticatedState(_userRepo.user!));
    }
  }

  Future<void> _completeProfileForm(
    ProfileFormCompletedRequested event,
    Emitter<GeneralAuthManagerState> emit,
  ) async {
    _userRepo.setKey(profileFormKey, false);
    // TODO check
    // emit(AuthenticatedState(_userRepo.user!));
    emit(AuthenticatedState(_userRepo.user));
  }

  Future<void> _signOut(
    SignOutRequested event,
    Emitter<GeneralAuthManagerState> emit,
  ) async {
    await _userRepo.deleteUser();
    emit(UnauthenticatedState());
  }

  void _continueAsGuest(
    GuestRequested event,
    Emitter<GeneralAuthManagerState> emit,
  ) {
    // TODO check
    emit(AuthenticatedState(null));
    // emit(GuestState());
  }
}
