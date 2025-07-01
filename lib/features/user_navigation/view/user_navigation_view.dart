import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
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
  int currentIndex = 1;

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
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        return MainAppBar();
      },
      routes: const [ProfileRoute(), DashboardRoute(), AddsAndOffersRoute()],
      extendBody: true,
      resizeToAvoidBottomInset: true,
      bottomNavigationBuilder: (context, tabsRouter) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: context.cs.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            boxShadow: kElevationToShadow[4],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Padding(
              padding: AppConstants.padding20,
              child: GNav(
                  selectedIndex: currentIndex,
                  onTabChange: (value) {
                    onBottomTab(tabsRouter.activeIndex, value, tabsRouter);
                  },
                  tabBorderRadius: 15,
                  curve: Curves.easeOutExpo,
                  duration: Duration(milliseconds: 500),
                  gap: 8,
                  activeColor: context.cs.primary,
                  iconSize: 24,
                  tabBackgroundColor: context.cs.primary.withValues(alpha: 0.3),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  tabs: [
                    GButton(
                      icon: Icons.person,
                      text: 'profile'.tr(),
                    ),
                    GButton(
                      icon: Icons.home,
                      text: 'home'.tr(),
                    ),
                    GButton(
                      icon: Icons.local_offer,
                      text: 'adds_and_offers'.tr(),
                    )
                  ]),
            ),
          ),
        );
        // return DecoratedBox(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        //     boxShadow: kElevationToShadow[2],
        //   ),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        //     child: BottomNavigationBar(
        //       currentIndex: tabsRouter.activeIndex,
        //       onTap: (index) {
        //         onBottomTab(tabsRouter.activeIndex, index, tabsRouter);
        //       },
        //       items: [
        //         BottomNavigationBarItem(
        //           icon: getBottomBarIcon(
        //             Icons.person,
        //             isSelected: tabsRouter.activeIndex == 0,
        //           ),
        //           label: 'profile'.tr(),
        //         ),
        //         BottomNavigationBarItem(
        //           icon: getBottomBarIcon(
        //             Icons.home,
        //             isSelected: tabsRouter.activeIndex == 1,
        //           ),
        //           label: 'home'.tr(),
        //         ),
        //         BottomNavigationBarItem(
        //           icon: getBottomBarIcon(
        //             Icons.local_offer,
        //             isSelected: tabsRouter.activeIndex == 2,
        //           ),
        //           label: 'adds_and_offers'.tr(),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }
}
