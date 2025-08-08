import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/profile/cubit/profile_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';

@RoutePage(name: 'ProfileRouter')
class ProfileRouter extends StatelessWidget {
  const ProfileRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<ProfileCubit>(),
      child: const AutoRouter(),
    );
  }
}
