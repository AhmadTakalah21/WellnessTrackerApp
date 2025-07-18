import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'app_manager_state.dart';

@injectable
class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerInitial());

  void emitLanuageChangedState() {
    emit(LanguageChanged());
  }

  void emitInnerRouteChanged() {
    emit(InnerRouteChanged());
  }
}
