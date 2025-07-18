import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:wellnesstrackerapp/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
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
    return BlocProvider(
      create: (context) => get<AppManagerCubit>(),
      child: const UserNavigationPage(),
    );
  }
}

class UserNavigationPage extends StatefulWidget {
  const UserNavigationPage({super.key});

  @override
  State<UserNavigationPage> createState() => _UserNavigationPageState();
}

class _UserNavigationPageState extends State<UserNavigationPage>
    implements UserNavigationViewCallbacks {
  int currentIndex = 0;
  bool get isRtl => context.locale.languageCode == 'ar';

  @override
  void onBottomTab(int currentIndex, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(currentIndex);
    setState(() {
      this.currentIndex = currentIndex;
    });
  }

  Widget getBottomBarIcon(IconData icon, {required bool isSelected}) {
    final color = isSelected ? context.cs.primary : context.cs.secondary;
    return Icon(icon, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final icons = [Icons.local_offer, Icons.home, Icons.person];
    final labels = ['adds_and_offers'.tr(), 'home'.tr(), 'profile'.tr()];

    final rtlIcons = icons.reversed.toList();
    final rtlLabels = labels.reversed.toList();
    return BlocListener<AppManagerCubit, AppManagerState>(
      listener: (context, state) {
        if (state is InnerRouteChanged) setState(() {});
      },
      child: AutoTabsScaffold(
        // appBarBuilder: (context, tabsRouter) {
        //   return MainAppBar();
        // },

        appBarBuilder: (context, tabsRouter) {
          if (tabsRouter.activeIndex == 1) {
            final nestedRouter =
                context.innerRouterOf<StackRouter>(DashboardRouter.name);

            final nestedRouteName = nestedRouter?.current.name;
            print("Nested route inside DashboardRouter: $nestedRouteName");
            if (nestedRouteName == DashboardRoute.name) {
              return const MainAppBar();
            } else {
              return const PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: SizedBox.shrink(),
              );
            }
          } else {
            return const MainAppBar();
          }
        },

        routes: [
          ProfileRoute(),
          DashboardRouter(),
          AddsAndOffersRoute(role: UserRoleEnum.user),
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
                  offset: Offset(0, -2),
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
              tabSelectedColor: context.cs.primary.withValues(alpha: 0.15),
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
