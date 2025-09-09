import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:wellnesstrackerapp/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:wellnesstrackerapp/global/localization/supported_locales.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class UserNavigationViewCallbacks {
  void onBottomTab(int currentIndex, TabsRouter tabsRouter);
}

@RoutePage()
class UserNavigationView extends StatelessWidget {
  const UserNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserNavigationPage();
  }
}

class _TabInfo {
  final String translationKey;
  final IconData icon;

  const _TabInfo(this.translationKey, this.icon);
}

class UserNavigationPage extends StatefulWidget {
  const UserNavigationPage({super.key});

  @override
  State<UserNavigationPage> createState() => _UserNavigationPageState();
}

class _UserNavigationPageState extends State<UserNavigationPage>
    with SingleTickerProviderStateMixin
    implements UserNavigationViewCallbacks {
  late MotionTabBarController controller;
  int currentIndex = 0;
  late final locale = context.locale;
  bool get isRtl => locale == SupportedLocales.arabic;

  final List<_TabInfo> tabs = const [
    _TabInfo('adds_and_offers', Icons.local_offer),
    _TabInfo('home', Icons.home),
    _TabInfo('profile', Icons.person),
  ];

  @override
  void initState() {
    super.initState();
    controller = MotionTabBarController(length: tabs.length, vsync: this);
  }

  @override
  void onBottomTab(int currentIndex, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(currentIndex);
    setState(() {
      this.currentIndex = currentIndex;
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labels = tabs.map((e) => e.translationKey.tr()).toList();
    final icons = tabs.map((e) => e.icon).toList();
    final rtlLabels = labels.reversed.toList();
    final rtlIcons = icons.reversed.toList();

    return AutoTabsScaffold(
      routes: isRtl
          ? [
              ProfileRouter(),
              DashboardRouter(),
              AddsAndOffersRouter(),
            ]
          : [
              AddsAndOffersRouter(),
              DashboardRouter(),
              ProfileRouter(),
            ],
      extendBody: true,
      resizeToAvoidBottomInset: true,
      bottomNavigationBuilder: (context, tabsRouter) {
        return BlocListener<AppManagerCubit, AppManagerState>(
          listener: (context, state) {
            if (state is BottomNavTabChanged) {
              onBottomTab(state.index, tabsRouter);
              controller.animateTo(state.index);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: context.cs.surface,
              borderRadius: AppConstants.borderRadiusTlTr,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: MotionTabBar(
              controller: controller,
              labels: isRtl ? rtlLabels : labels,
              icons: isRtl ? rtlIcons : icons,
              initialSelectedTab: isRtl ? rtlLabels[1] : labels[1],
              tabSize: 60,
              tabBarHeight: 65,
              textStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: context.cs.primary,
              ),
              tabIconColor: Colors.grey.shade500,
              tabIconSelectedColor: context.cs.primary,
              tabSelectedColor: context.cs.primary.withOpacity(0.15),
              tabBarColor: context.cs.surface,
              useSafeArea: true,
              onTabItemSelected: (index) {
                onBottomTab(index, tabsRouter);
              },
            ),
          ),
        );
      },
    );
  }
}
