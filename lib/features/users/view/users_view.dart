import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/features/users/view/widgets/add_user_widget.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class UsersViewCallBacks {
  void onAddTap();
  void onShowDetailsTap(UserModel user);
  void onEditTap(UserModel user);
  void onDeleteTap(UserModel user);
  void onSelectPageTap(int page, int perPage);
  void onSearchChanged(String input);
  void onTryAgainTap();
}

@RoutePage()
class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<UsersCubit>(),
      child: UsersPage(),
    );
  }
}

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> implements UsersViewCallBacks {
  late final UsersCubit usersCubit = context.read();

  int selectedPage = 1;
  int perPage = 10;

  @override
  void initState() {
    super.initState();
    usersCubit.getUsers(page: selectedPage, perPage: perPage);
  }

  @override
  void onAddTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (context) => AddUserView(
        usersCubit: usersCubit,
        selectedPage: selectedPage,
        onSuccess: onTryAgainTap,
      ),
    );
  }

  @override
  void onShowDetailsTap(UserModel user) {
    context.router.push(CustomersRoute(role: UserRoleEnum.admin, user: user));
  }

  @override
  void onDeleteTap(UserModel user) {
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(item: user, onSuccess: onTryAgainTap),
    );
  }

  @override
  void onEditTap(UserModel user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (context) => AddUserView(
        usersCubit: usersCubit,
        user: user,
        selectedPage: selectedPage,
        onSuccess: onTryAgainTap,
      ),
    );
  }

  @override
  void onSelectPageTap(int page, int perPage) {
    setState(() {
      selectedPage = page;
      this.perPage = perPage;
    });
    usersCubit.getUsers(page: page, perPage: perPage);
  }

  void selectRole(DepartmentEnum? role) => usersCubit.setRoleFilter(role);

  @override
  void onSearchChanged(String input) => usersCubit.setQueryFilter(input);

  @override
  void onTryAgainTap() {
    usersCubit.getUsers(page: selectedPage, perPage: perPage);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(title: Text('employees_administration'.tr())),
      backgroundColor: context.cs.surface,
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<UsersCubit, GeneralUsersState>(
                buildWhen: (previous, current) => current is UsersState,
                builder: (context, state) {
                  if (state is UsersLoading) {
                    return LoadingIndicator(
                      color: context.cs.primary,
                      height: height / 1.2,
                    );
                  } else if (state is UsersSuccess) {
                    return MainDataTable<UserModel>(
                      titles: UserModel.titles,
                      items: state.users,
                      onPageChanged: onSelectPageTap,
                      onShowDetailsTap: onShowDetailsTap,
                      onEditTap: onEditTap,
                      onDeleteTap: onDeleteTap,
                      emptyMessage: state.emptyMessage,
                      onSearchChanged: onSearchChanged,
                      searchHint: "search_employee",
                      filters: [_buildDepartmentFilter()],
                    );
                  } else if (state is UsersEmpty) {
                    return MainErrorWidget(
                      error: state.message,
                      onTryAgainTap: onTryAgainTap,
                      height: 2.5,
                      isRefresh: true,
                    );
                  } else if (state is UsersFail) {
                    return MainErrorWidget(
                      error: state.error,
                      height: 2.5,
                      onTryAgainTap: onTryAgainTap,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: MainFloatingButton(onTap: onAddTap),
    );
  }

  Widget _buildDepartmentFilter() {
    return MainDropDownWidget(
      items: DepartmentEnum.values,
      onChanged: selectRole,
      hintText: 'select_role'.tr(),
      labelText: 'role'.tr(),
      prefixIcon: LucideIcons.shieldCheck,
    );
  }
}
