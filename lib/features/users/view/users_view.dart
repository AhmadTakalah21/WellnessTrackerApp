import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/features/users/view/widgets/add_user_widget.dart';
import 'package:wellnesstrackerapp/global/blocs/delete_cubit/cubit/delete_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

import '../../../global/blocs/user_roles_cubit/cubit/user_roles_cubit.dart';

abstract class UsersViewCallBacks {
  void onAddTap();
  void onEditTap(UserModel user);
  void onDeleteTap(UserModel user);
  void onSaveDeleteTap(UserModel user);
  void onSelectPageTap(int page, int perPage);
  Future<void> onRefresh();
  void onTryAgainTap();
}

@RoutePage()
class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => get<UsersCubit>()),
        BlocProvider(create: (context) => get<UserRolesCubit>()),
        BlocProvider(create: (context) => get<DeleteCubit>()),
      ],
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
  late final DeleteCubit deleteCubit = context.read();

  int selectedPage = 1;

  @override
  void initState() {
    super.initState();
    usersCubit.getUsers(page: selectedPage);
  }

  @override
  void onAddTap() {
    final usersCubit = context.read<UsersCubit>();
    final rolesCubit = context.read<UserRolesCubit>()..getRoles();

    showDialog(
      context: context,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: usersCubit),
          BlocProvider.value(value: rolesCubit),
        ],
        child: AddUserWidget(
          isEdit: false,
          selectedPage: selectedPage,
        ),
      ),
    );
  }


  @override
  void onDeleteTap(UserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return InsureDeleteWidget(
          deleteCubit: deleteCubit,
          item: user,
          onSaveTap: onSaveDeleteTap,
          onSuccess: onTryAgainTap,
        );
      },
    );
  }

  @override
  void onSaveDeleteTap(UserModel user) {
    deleteCubit.deleteItem<UserModel>(user);
  }

  @override
  void onEditTap(UserModel user) {
    final usersCubit = context.read<UsersCubit>();
    final rolesCubit = context.read<UserRolesCubit>()..getRoles();

    showDialog(
      context: context,
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: usersCubit),
          BlocProvider.value(value: rolesCubit),
        ],
        child: AddUserWidget(
          isEdit: true,
          user: user,
          selectedPage: selectedPage,
        ),
      ),
    );
  }


  @override
  void onSelectPageTap(int page, int perPage) {
    // if (selectedPage != page) {
    //   setState(() {
    //     selectedPage = page;
    //   });
    usersCubit.getUsers(page: page, perPage: perPage);
    //}
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => usersCubit.getUsers(page: selectedPage);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text(
          'employees_administration'.tr(),
          style: context.tt.titleLarge,
        ),
      ),
      backgroundColor: context.cs.onSurface,
      body: Padding(
        padding: AppConstants.padding16,
        child: BlocBuilder<UsersCubit, GeneralUsersState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              return LoadingIndicator(
                color: context.cs.primary,
                height: height / 1.2,
              );
            } else if (state is UsersSuccess) {
              return MainDataTable<UserModel>(
                header: UserModel.header,
                titles: UserModel.titles,
                items: state.users,
                onPageChanged: (page, perPage) =>
                    onSelectPageTap(page, perPage),
                onEditTap: onEditTap,
                onDeleteTap: onDeleteTap,
                emptyMessage: state.emptyMessage,
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
      floatingActionButton: MainAddFloatingButton(onAddTap: onAddTap),
    );
  }
}
