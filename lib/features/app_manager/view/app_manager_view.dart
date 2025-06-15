import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AppManagerView extends StatelessWidget {
  const AppManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppManagerPage();
  }
}

class AppManagerPage extends StatelessWidget {
  const AppManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
