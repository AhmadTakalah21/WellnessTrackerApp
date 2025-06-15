import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/router/app_router.dart';
import 'package:wellnesstrackerapp/global/theme/themes/dark_theme.dart';

class AppMaterialApp extends StatefulWidget {
  const AppMaterialApp({super.key});

  @override
  State<AppMaterialApp> createState() => _AppMaterialAppState();
}

class _AppMaterialAppState extends State<AppMaterialApp> {
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Health & Wellness App',
      theme: darkTheme,
    );
  }
}
