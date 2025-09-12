import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/select_plan/model/user_plans_model/fake_user_plans.dart';
import 'package:wellnesstrackerapp/features/select_plan/model/user_plans_model/user_plans_model.dart';
import 'package:wellnesstrackerapp/features/select_plan/service/user_plans_service.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

part 'states/user_plans_state.dart';
part 'states/general_user_plans_state.dart';

@injectable
class UserPlansCubit extends Cubit<GeneralUserPlansState> {
  UserPlansCubit(this.userPlansService) : super(GeneralUserPlansInitial());
  final UserPlansService userPlansService;

  Future<void> getPlans() async {
    if (!get<UserRepo>().isSignedIn) {
      emit(UserPlansSuccess(fakeUserPlans));
      return;
    }
    emit(UserPlansLoading());
    try {
      if (isClosed) return;
      final result = await userPlansService.getPlans();
      if (result.plans.isEmpty) {
        emit(UserPlansEmpty("no_plans".tr()));
      } else {
        emit(UserPlansSuccess(result));
      }
    } catch (e) {
      if (isClosed) return;
      emit(UserPlansFail(e.toString()));
    }
  }
}
