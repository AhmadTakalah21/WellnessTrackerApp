import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/users/model/add_user_model/add_user_model.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/features/users/service/users_service.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'states/users_state.dart';
part 'states/general_users_state.dart';
part 'states/add_user_state.dart';

@injectable
class UsersCubit extends Cubit<GeneralUsersState> {
  UsersCubit(this.userService) : super(GeneralUsersInitial());
  final UserService userService;
  AddUserModel addUserModel = const AddUserModel();

  void setName(String? name) {
    addUserModel = addUserModel.copyWith(name: () => name);
  }

  void setEmail(String? email) {
    addUserModel = addUserModel.copyWith(email: () => email);
  }

  void setPassword(String? password) {
    addUserModel = addUserModel.copyWith(password: () => password);
  }

  void setPhone(String? phone) {
    addUserModel = addUserModel.copyWith(phone: () => phone);
  }

  void setIsActive(bool? isActive) {
    addUserModel = addUserModel.copyWith(isActive: () => isActive);
  }

  void setRole(String? role) {
    addUserModel = addUserModel.copyWith(role: () => role);
  }

  Future<void> getUsers({int perPage = 10, required int page}) async {
    emit(UsersLoading());
    try {
      if (isClosed) return;
      final users = await userService.getUsers(page: page, perPage: perPage);
      emit(UsersSuccess(users, users.data.isEmpty ? "no_users".tr() : null));
      // if (users.data.isEmpty) {
      //   emit(UsersEmpty("no_users".tr()));
      // } else {
      //   emit(UsersSuccess(users));
      // }
    } catch (e) {
      if (isClosed) return;
      emit(UsersFail(e.toString()));
    }
  }

  Future<void> addUser({required bool isAdd, int? userId}) async {
    emit(AddUserLoading());
    try {
      final response = await userService.addUser(
        addUserModel,
        isAdd: isAdd,
        userId: userId,
      );
      final message = isAdd ? "user_added".tr() : "user_updated".tr();
      emit(AddUserSuccess(response, message));
    } catch (e) {
      emit(AddUserFail(e.toString()));
    }
  }
}
