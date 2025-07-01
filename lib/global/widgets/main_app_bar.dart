import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<AuthCubit>(),
      child: const MainAppBarImp(),
    );
  }
}

class MainAppBarImp extends StatefulWidget {
  const MainAppBarImp({super.key});

  @override
  State<MainAppBarImp> createState() => _MainAppBarImpState();
}

class _MainAppBarImpState extends State<MainAppBarImp> {
  late final AuthCubit authCubit = context.read();

  void onLogoutTap() => authCubit.logout();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.cs.primary,
      elevation: 4,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 20),
          Text('Health & Wellness App', style: context.tt.titleLarge),
        ],
      ),
      actions: [
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
              color: context.cs.secondary,
              onPressed: onLogoutTap,
              icon: const Icon(Icons.logout_rounded),
            );
          },
        ),
      ],
    );
  }
}
