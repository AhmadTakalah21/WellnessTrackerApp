
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';
import '../../adds_and_offers/view/adds_and_offers_view.dart';
import '../../dashboard/view/dashboard_view.dart';
import '../../profile/view/profile_view.dart';

class UserNavigationView extends StatefulWidget {
  const UserNavigationView({super.key});

  @override
  State<UserNavigationView> createState() => _UserNavigationViewState();
}

class _UserNavigationViewState extends State<UserNavigationView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> pages = const [
    ProfileView(),
    DashboardView(),
    AddsAndOffersView(),
  ];

  bool get isRtl => context.locale.languageCode == 'ar';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: pages.length, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icons = [Icons.person, Icons.home, Icons.local_offer];
    final labels = ['profile'.tr(), 'home'.tr(), 'adds_and_offers'.tr()];

    final rtlIcons = icons.reversed.toList();
    final rtlLabels = labels.reversed.toList();

    return Scaffold(
      appBar: MainAppBar(),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: isRtl ? pages.reversed.toList() : pages,
      ),
      bottomNavigationBar: Container(
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
            setState(() {
              _tabController.index = index;
            });
          },
        ),
      ),
    );
  }
}
