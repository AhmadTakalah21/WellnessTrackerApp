import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/features/notifications/cubit/notifications_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title = AppConstants.appName,
    this.automaticallyImplyLeading = false,
    this.hasLogout = true,
    this.role = UserRoleEnum.admin,
  });

  final String title;
  final bool automaticallyImplyLeading;
  final bool hasLogout;
  final UserRoleEnum role;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => get<AuthCubit>()),
        BlocProvider(create: (context) => get<NotificationsCubit>()),
      ],
      child: MainAppBarImp(
        title: title,
        automaticallyImplyLeading: automaticallyImplyLeading,
        hasLogout: hasLogout,
        role: role,
      ),
    );
  }
}

class MainAppBarImp extends StatefulWidget {
  const MainAppBarImp({
    super.key,
    required this.title,
    required this.automaticallyImplyLeading,
    required this.hasLogout,
    required this.role,
  });

  final String title;
  final bool automaticallyImplyLeading;
  final bool hasLogout;
  final UserRoleEnum role;

  @override
  State<MainAppBarImp> createState() => _MainAppBarImpState();
}

class _MainAppBarImpState extends State<MainAppBarImp> {
  late final AuthCubit authCubit = context.read();
  late final NotificationsCubit notificationsCubit = context.read();
  late final SignInModel? user = context.read<SignInModel?>();

  bool isNotificationsViewed = false;

  @override
  void initState() {
    super.initState();
    if (user != null && widget.role.isUser) {
      notificationsCubit.getUnreadNotificationsCount(widget.role);
    }
  }

  void onLogoutTap() => authCubit.logout();

  // void onNotificationTap() => context.router.push(
  //       NotificationsRoute(role: widget.role),
  //     );

  void onNotificationTap() {
    setState(() => isNotificationsViewed = true);
    context.router.push(NotificationsRoute(role: widget.role));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      leading: widget.role.isUser
          ? _buildNotificationIcon()
          // ? Badge(
          //     offset: Offset(12, 6),
          //     isLabelVisible: !isNotificationsViewed,
          //     label: Text("10"),
          //     child: IconButton(
          //       iconSize: 35,
          //       onPressed: onNotificationTap,
          //       icon: Icon(
          //         Icons.notifications_outlined,
          //         color: context.cs.secondary,
          //       ),
          //     ),
          //   )
          : null,
      title: Text(widget.title),
      actions: [
        if (widget.hasLogout)
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LogOutSuccess) {
                MainSnackBar.showSuccessMessage(context, state.message);
              } else if (state is SignInFail) {
                MainSnackBar.showErrorMessage(context, state.error);
              }
            },
            builder: (context, state) {
              if (state is SignInLoading) {
                return LoadingIndicator(color: context.cs.secondary);
              }
              return IconButton(
                iconSize: 35,
                onPressed: onLogoutTap,
                icon: const Icon(Icons.logout_rounded),
              );
            },
          ),
        SizedBox(width: 8),
      ],
    );
  }

  Widget _buildNotificationIcon() {
    return BlocBuilder<NotificationsCubit, GeneralNotificationsState>(
      builder: (context, state) {
        int count = 0;
        bool isVisible =
            state is UnreadNotificationsCountSuccess && state.count != 0;
        if (isVisible) count = state.count;
        return Badge(
          offset: Offset(12, 6),
          isLabelVisible: isVisible && !isNotificationsViewed,
          label: Text(count.toString()),
          child: IconButton(
            iconSize: 35,
            onPressed: onNotificationTap,
            icon: Icon(
              Icons.notifications_outlined,
              color: context.cs.secondary,
            ),
          ),
        );
      },
    );
  }
}
