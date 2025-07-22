import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/widgets/restart_app_widget.dart';

@RoutePage()
class AppManagerView extends StatelessWidget {
  const AppManagerView({super.key, required this.user});

  final SignInModel user;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: user,
      child: BlocProvider(
        create: (context) => get<AppManagerCubit>(),
        child: AppManagerPage(user: user),
      ),
    );
  }
}

class AppManagerPage extends StatefulWidget {
  const AppManagerPage({super.key, required this.user});

  final SignInModel user;

  @override
  State<AppManagerPage> createState() => _AppManagerPageState();
}

class _AppManagerPageState extends State<AppManagerPage> {
  late final user = context.read<SignInModel>();

  @override
  Widget build(BuildContext context) {
    return RestartAppWidget(
      child: AutoRouter.declarative(
        routes: (_) {
          if (widget.user.role.isUser) {
            return [const UserNavigationRoute()];
          } else {
            return [const DashboardRouter()];
          }
        },
      ),
    );
  }
}
