import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'app_manager_state.dart';

@singleton
class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerInitial());

  // void emitLanuageChangedState(Locale locale) {
  //   emit(LanguageChanged(locale));
  // }

  void emitInnerRouteChanged() {
    emit(InnerRouteChanged());
  }
}
