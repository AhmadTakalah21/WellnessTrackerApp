import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';

@RoutePage()
class AppManagerView extends StatelessWidget {
  const AppManagerView({super.key, required this.user});

  final SignInModel user;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: user,
      child: const AppManagerPage(),
    );
  }
}

class AppManagerPage extends StatelessWidget {
  const AppManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
