import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
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
  });

  final String title;
  final bool automaticallyImplyLeading;
  final bool hasLogout;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<AuthCubit>(),
      child: MainAppBarImp(
        title: title,
        automaticallyImplyLeading: automaticallyImplyLeading,
        hasLogout: hasLogout,
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
  });

  final String title;
  final bool automaticallyImplyLeading;
  final bool hasLogout;

  @override
  State<MainAppBarImp> createState() => _MainAppBarImpState();
}

class _MainAppBarImpState extends State<MainAppBarImp> {
  late final AuthCubit authCubit = context.read();

  void onLogoutTap() => authCubit.logout();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: Text(widget.title,),
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
                return LoadingIndicator(color: context.cs.error);
              }
              return IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: onLogoutTap,
                icon: const Icon(Icons.logout_rounded),
              );
            },
          ),
      ],
    );
  }
}
