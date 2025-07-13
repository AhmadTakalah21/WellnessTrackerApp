import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart';
import 'package:wellnesstrackerapp/features/levels/view/levels_page_item.dart';
import 'package:wellnesstrackerapp/features/levels/view/widgets/add_level_widget.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/keep_alive_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_tab_bar.dart';

abstract class LevelsViewCallBacks {
  void onAddTap();
  void onTabSelected(int index);
  void onTryAgainTap();
}

@RoutePage()
class LevelsView extends StatelessWidget {
  const LevelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<LevelsCubit>(),
      child: const LevelsPage(),
    );
  }
}

class LevelsPage extends StatefulWidget {
  const LevelsPage({super.key});

  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage>
    with SingleTickerProviderStateMixin
    implements LevelsViewCallBacks {
  late final LevelsCubit levelsCubit = context.read();

  PageController pageController = PageController();
  late TabController tabController;
  int selectedTab = 0;

  final List<String> tabBarTitles =
      DepartmentEnum.values.map((e) => e.displayEntityName).toList();

  @override
  void initState() {
    super.initState();
    levelsCubit.getLevels();
    tabController = TabController(length: tabBarTitles.length, vsync: this);
  }

  @override
  void onTabSelected(int index) {
    setState(() => selectedTab = index);
    tabController.animateTo(index);
    pageController.jumpToPage(index);
    levelsCubit.setRoleFilter(DepartmentEnum.getDepartmentById(index + 1));
  }

  @override
  void onTryAgainTap() => levelsCubit.getLevels();

  @override
  void onAddTap() {
    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (bottomSheetContext) => AddLevelView(
        levelsCubit: levelsCubit,
        isEdit: false,
        onSuccess: () => levelsCubit.getLevels(),
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
    final pages = DepartmentEnum.values.map((department) {
      return LevelsPageItem(onTryAgainTap: onTryAgainTap);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('levels'.tr(), style: context.tt.titleLarge),
      ),
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
      floatingActionButton: MainFloatingButton(
        onTap: onAddTap,
      ),
    );
  }
}
