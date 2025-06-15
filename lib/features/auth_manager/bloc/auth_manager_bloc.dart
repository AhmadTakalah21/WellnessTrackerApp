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
    on<SignInRequested>(_signIn);
    on<SignOutRequested>(_signOut);
  }

  final UserRepo _userRepo;

  Future<void> _findIfAuthenticatedOrFirstTime(
    IsAuthenticatedOrFirstTime event,
    Emitter<GeneralAuthManagerState> emit,
  ) async {
    final firstTime = await _userRepo.getKey(firstTimeKey, defaultValue: true);
    if (firstTime) {
      emit(FirstTimeState());
      _userRepo.setKey(firstTimeKey, false);
    } else {
      if (_userRepo.user != null) {
        emit(AuthenticatedState(_userRepo.user!));
      } else {
        emit(UnauthenticatedState());
      }
    }
  }

  Future<void> _signIn(
    SignInRequested event,
    Emitter<GeneralAuthManagerState> emit,
  ) async {
    await _userRepo.setUser(event.signInModel);
    event.onSuccess?.call();
    emit(AuthenticatedState(event.signInModel));
  }

  Future<void> _signOut(
    SignOutRequested event,
    Emitter<GeneralAuthManagerState> emit,
  ) async {
    await _userRepo.deleteUser();
    emit(UnauthenticatedState());
  }
}
