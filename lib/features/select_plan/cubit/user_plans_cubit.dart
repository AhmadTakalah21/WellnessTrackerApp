import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/select_plan/model/user_plan_model/user_plan_model.dart';
import 'package:wellnesstrackerapp/features/select_plan/service/user_plans_service.dart';

part 'states/user_plans_state.dart';
part 'states/general_user_plans_state.dart';

@injectable
class UserPlansCubit extends Cubit<GeneralUserPlansState> {
  UserPlansCubit(this.userPlansService) : super(GeneralUserPlansInitial());
  final UserPlansService userPlansService;

  Future<void> getPlans() async {
    emit(UserPlansLoading());
    try {
      if (isClosed) return;
      final result = await userPlansService.getPlans();
      if (result.isEmpty) {
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
