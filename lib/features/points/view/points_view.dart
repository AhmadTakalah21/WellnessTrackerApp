import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/items/view/items_view.dart';
import 'package:wellnesstrackerapp/features/points/cubit/points_cubit.dart';
import 'package:wellnesstrackerapp/features/points/view/pages/current_points_view.dart';
import 'package:wellnesstrackerapp/features/points/view/pages/earn_points_ways_view.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/keep_alive_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_tab_bar.dart';

class ChartModel {
  ChartModel({
    required this.xAxisProperty,
    required this.yAxisProperty,
    this.isInChart = true,
    required this.color,
    this.icon,
  });

  final String xAxisProperty;
  final List<double> yAxisProperty;
  final bool isInChart;
  final Color color;
  final IconData? icon;
}

abstract class PointsViewCallBacks {
  void onTabSelected(int index);
  void onGoToStoreTap();
}

@RoutePage()
class PointsView extends StatelessWidget {
  const PointsView({super.key, required this.role});
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<PointsCubit>(),
      child: PointsPage(role: role),
    );
  }
}

class PointsPage extends StatefulWidget {
  const PointsPage({super.key, required this.role});
  final UserRoleEnum role;

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage>
    with SingleTickerProviderStateMixin
    implements PointsViewCallBacks {
  PageController pageController = PageController();
  late TabController tabController;
  int selectedTab = 0;

  final List<String> tabBarTitles = ["points", "get_points_methods"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabBarTitles.length, vsync: this);
  }

  @override
  void onTabSelected(int index) {
    setState(() => selectedTab = index);
    tabController.animateTo(index);
    pageController.jumpToPage(index);
  }

  @override
  void onGoToStoreTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemsView(role: UserRoleEnum.user),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CurrentPointsView(),
      EarnPointsWaysView(role: widget.role),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('points'.tr())),
      body: Column(
        children: [
          MainTabBar(
            titles: tabBarTitles,
            tabController: tabController,
            onTapSelected: onTabSelected,
            selectedTab: selectedTab,
            isScrollable: false,
          ),
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              onPageChanged: onTabSelected,
              itemCount: pages.length,
              itemBuilder: (context, index) => Padding(
                padding: AppConstants.padding16,
                child: KeepAliveWidget(child: pages[index]),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: MainFloatingButton(
          icon: Icons.storefront_outlined,
          onTap: onGoToStoreTap,
        ),
      ),
    );
  }
}
