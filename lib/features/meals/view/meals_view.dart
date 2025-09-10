import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_model/plan_day_model.dart';
import 'package:wellnesstrackerapp/features/meals/view/widgets/meal_tile.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/keep_alive_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_tab_bar.dart';

abstract class MealsViewCallbacks {
  void onTabSelected(int index);
  void onTryAgainTap();
  Future<void> onRefresh();
}

@RoutePage()
class MealsView extends StatelessWidget {
  const MealsView({super.key, required this.role});
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<MealPlansCubit>(),
      child: MealsPage(role: role),
    );
  }
}

class MealsPage extends StatefulWidget {
  const MealsPage({super.key, required this.role});
  final UserRoleEnum role;

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage>
    with TickerProviderStateMixin
    implements MealsViewCallbacks {
  late final MealPlansCubit mealPlansCubit = context.read();
  late final PageController pageController;
  TabController? tabController;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    mealPlansCubit.getMealPlans(widget.role);
  }

  @override
  void dispose() {
    pageController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() {
    selectedTab = 0;
    mealPlansCubit.getMealPlans(widget.role);
  }

  @override
  void onTabSelected(int index) {
    setState(() => selectedTab = index);
    tabController?.animateTo(index);
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('meals'.tr())),
      body: BlocConsumer<MealPlansCubit, GeneralMealPlansState>(
        buildWhen: (previous, current) => current is MealPlansState,
        listener: (context, state) {
          if (state is MealPlansSuccess) {
            final planDays = state.mealPlans.data.last.planDays;
            final titles = planDays.map((e) => e.day.displayName).toList();
            tabController?.dispose();
            tabController = TabController(length: titles.length, vsync: this);
          }
        },
        builder: (context, state) {
          if (state is MealPlansLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is MealPlansSuccess) {
            final planDays = state.mealPlans.data.last.planDays;
            return Column(
              children: [
                MainTabBar(
                  titles: planDays.map((e) => e.day.displayName).toList(),
                  tabController: tabController!,
                  onTapSelected: onTabSelected,
                  selectedTab: selectedTab,
                ),
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    onPageChanged: onTabSelected,
                    itemCount: planDays.length,
                    itemBuilder: (context, index) {
                      final planDay = planDays[index];
                      final child = planDay.meals.isEmpty
                          ? MainErrorWidget(
                              error: "no_meals".tr(),
                              isRefresh: true,
                              onTryAgainTap: onTryAgainTap,
                            )
                          : _buildPage(planDay);
                      return Padding(
                        padding: AppConstants.padding16,
                        child: KeepAliveWidget(child: child),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is MealPlansEmpty) {
            return MainErrorWidget(
              error: state.message,
              isRefresh: true,
              onTryAgainTap: onTryAgainTap,
            );
          } else if (state is MealPlansFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildPage(PlanDayModel planDay) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        padding: AppConstants.paddingH10,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ...planDay.meals.map((meal) => MealTile(meal: meal)),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
