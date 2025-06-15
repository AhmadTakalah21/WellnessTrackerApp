import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth_manager/bloc/auth_manager_bloc.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/features/app/material_app.dart';
import 'package:wellnesstrackerapp/global/localization/supported_locales.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => get<UserRepo>())],
      child: BlocProvider(
        create: (context) => get<AuthManagerBloc>(),
        child: EasyLocalization(
          supportedLocales: SupportedLocales.locales,
          path: SupportedLocales.path,
          fallbackLocale: SupportedLocales.arabic,
          startLocale: SupportedLocales.arabic,
          child: const AppMaterialApp(),
        ),
      ),
    );
  }
}
