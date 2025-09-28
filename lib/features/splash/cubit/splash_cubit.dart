import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/splash/service/splash_service.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

part 'states/splash_state.dart';
part 'states/general_splash_state.dart';
part 'states/check_version_state.dart';

@injectable
class SplashCubit extends Cubit<GeneralSplashState> {
  SplashCubit(this.splashSerivce, this.userRepo)
      : super(GeneralSplashInitial());
  final SplashSerivce splashSerivce;
  final UserRepo userRepo;
  Future<void> checkVersion() async {
    emit(CheckVersionLoading());
    if (userRepo.isV1) {
      emit(CheckVersionSuccess(userRepo.isV1));
      return;
    }
    try {
      if (isClosed) return;
      final isV1 = await splashSerivce.checkVersion();
      userRepo.setIsV1(isV1);
      emit(CheckVersionSuccess(isV1));
    } catch (e) {
      if (isClosed) return;
      emit(CheckVersionSuccess(false));
    }
  }
}
