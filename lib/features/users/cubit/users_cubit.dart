import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/users/model/add_user_model/add_user_model.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/features/users/service/users_service.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

import '../../../global/models/meta_model/meta_model.dart';

part 'states/users_state.dart';
part 'states/general_users_state.dart';
part 'states/add_user_state.dart';

@injectable
class UsersCubit extends Cubit<GeneralUsersState> {
  UsersCubit(this.userService) : super(GeneralUsersInitial());
  final UserService userService;
  AddUserModel addUserModel = const AddUserModel();

  List<UserModel> _allUsers = [];

  DepartmentEnum? roleFilter;
  String? query;

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

  void setRole(String? role) {
    addUserModel = addUserModel.copyWith(role: () => role);
  }

  void setRoleFilter(DepartmentEnum? role) {
    roleFilter = role;
    _applyFilters(_allUsers, query: query, role: role?.name);
  }

  void setQueryFilter(String? query) {
    this.query = query;
    _applyFilters(_allUsers, query: query, role: roleFilter?.name);
  }

  Future<void> getUsers({int? perPage = 10, int? page}) async {
    emit(UsersLoading());
    try {
      if (isClosed) return;
      final users = await userService.getUsers(page: page, perPage: perPage);
      _allUsers = users.data;
      _applyFilters(_allUsers, query: query, role: roleFilter?.name);
      //emit(UsersSuccess(users, users.data.isEmpty ? "no_users".tr() : null));
    } catch (e) {
      if (isClosed) return;
      emit(UsersFail(e.toString()));
    }
  }

  List<UserModel> _applyFilters(
    List<UserModel> source, {
    String? query,
    String? role,
  }) {
    final filtered = source.where((user) {
      final matchesQuery = query == null ||
          user.name.toLowerCase().contains(query.toLowerCase());
      final matchesRole =
          role == null || user.role.toLowerCase() == role.toLowerCase();
      return matchesQuery && matchesRole;
    }).toList();

    final result = PaginatedModel<UserModel>(
      data: filtered,
      meta: MetaModel(
        total: filtered.length,
        count: filtered.length,
        perPage: filtered.length,
        currentPage: 1,
        totalPages: 1,
      ),
    );

    emit(UsersSuccess(result, filtered.isEmpty ? "no_users".tr() : null));
    return filtered;
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
