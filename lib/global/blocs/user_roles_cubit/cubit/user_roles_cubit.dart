import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/global/models/user_role_model/user_role_model.dart';
import 'package:wellnesstrackerapp/global/services/user_role_service/user_role_service.dart';

part 'user_roles_state.dart';

@injectable
class UserRolesCubit extends Cubit<UserRolesState> {
  UserRolesCubit(this.userRoleService) : super(UserRolesInitial());
  final UserRoleService userRoleService;

  Future<void> getRoles() async {
    emit(UserRolesLoading());
    try {
      final roles = await userRoleService.getUserRoles();
      if (roles.isEmpty) {
        emit(UserRolesEmpty("no_roles".tr()));
      } else {
        emit(UserRolesSuccess(roles));
      }
    } catch (e) {
      emit(UserRolesFail("failed_to_load_roles".tr()));
    }
  }
}
