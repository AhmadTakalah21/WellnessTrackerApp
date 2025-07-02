import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';

abstract class UserNavigationViewCallbacks {
  void onBottomTab(
    int previousIndex,
    int currentIndex,
    TabsRouter tabsRouter,
  );
}

@RoutePage()
class UserNavigationView extends StatelessWidget {
  const UserNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserNavigationPage();
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
  void onBottomTab(int previousIndex, int currentIndex, TabsRouter tabsRouter) {
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
    final icons = [Icons.person, Icons.home, Icons.local_offer];
    final labels = ['profile'.tr(), 'home'.tr(), 'adds_and_offers'.tr()];

    final rtlIcons = icons.reversed.toList();
    final rtlLabels = labels.reversed.toList();
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        return MainAppBar();
      },
      routes: const [ProfileRoute(), DashboardRoute(), AddsAndOffersRoute()],
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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
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
              onBottomTab(tabsRouter.activeIndex, index, tabsRouter);
            },
          ),
        );
      },
    );
  }
}
