import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:wellnesstrackerapp/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:wellnesstrackerapp/global/localization/supported_locales.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';

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
    implements UserNavigationViewCallbacks {
  int currentIndex = 0;
  late final locale = context.locale;
  bool get isRtl => locale == SupportedLocales.arabic;

  final List<_TabInfo> tabs = const [
    _TabInfo('adds_and_offers', Icons.local_offer),
    _TabInfo('home', Icons.home),
    _TabInfo('profile', Icons.person),
  ];

  @override
  void onBottomTab(int currentIndex, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(currentIndex);
    setState(() {
      this.currentIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labels = tabs.map((e) => e.translationKey.tr()).toList();
    final icons = tabs.map((e) => e.icon).toList();
    final rtlLabels = labels.reversed.toList();
    final rtlIcons = icons.reversed.toList();

    return BlocListener<AppManagerCubit, AppManagerState>(
      listener: (context, state) {
       // if (state is InnerRouteChanged) setState(() {});
      },
      child: AutoTabsScaffold(
        appBarBuilder: (context, tabsRouter) {
          String titleKey = 'app_name';

          if (tabsRouter.activeIndex == 1) {
            final nestedRouter = context.innerRouterOf<StackRouter>(DashboardRouter.name);
            final nestedRouteName = nestedRouter?.current.name;

            switch (nestedRouteName) {
              case 'DashboardRoute':
                titleKey = 'home';
                break;
              default:
                titleKey = 'home';
            }
          } else {
            final index = tabsRouter.activeIndex;
            titleKey = isRtl
                ? tabs.reversed.toList()[index].translationKey
                : tabs[index].translationKey;
          }

          return MainAppBar(title: titleKey.tr());
        },

        routes: isRtl
            ? [
          ProfileRoute(),
          DashboardRouter(),
          AddsAndOffersRoute(role: UserRoleEnum.user),
        ]
            : [
          AddsAndOffersRoute(role: UserRoleEnum.user),
          DashboardRouter(),
          ProfileRoute(),
        ],
        extendBody: true,
        resizeToAvoidBottomInset: true,
        bottomNavigationBuilder: (context, tabsRouter) {
          return Container(
            decoration: BoxDecoration(
              color: context.cs.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                )
              ],
              borderRadius: AppConstants.borderRadiusTlTr,
            ),
            child: MotionTabBar(
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
          );
        },
      ),
    );
  }
}
