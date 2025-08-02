import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_model/plan_day_model.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
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

  PageController pageController = PageController();
  late TabController tabController;
  int selectedTab = 0;

  // final List<String> tabBarTitles =
  //     DayEnum.values.map((day) => day.displayName).toList();

  @override
  void initState() {
    super.initState();
    mealPlansCubit.getMealPlans(widget.role);
    // tabController = TabController(length: tabBarTitles.length, vsync: this);
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => mealPlansCubit.getMealPlans(widget.role);

  @override
  void onTabSelected(int index) {
    setState(() => selectedTab = index);
    tabController.animateTo(index);
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('meals'.tr(), style: context.tt.titleLarge),
      ),
      body: BlocBuilder<MealPlansCubit, GeneralMealPlansState>(
        buildWhen: (previous, current) => current is MealPlansState,
        builder: (context, state) {
          if (state is MealPlansLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is MealPlansSuccess) {
            final meals = state.mealPlans.data;
            final tabBarTitles =
                meals.last.planDays.map((e) => e.day.displayName).toList();
            tabController =
                TabController(length: tabBarTitles.length, vsync: this);
            return Column(
              children: [
                MainTabBar(
                  //titles: tabBarTitles,
                  titles: meals.last.planDays
                      .map((e) => e.day.displayName)
                      .toList(),
                  tabController: tabController,
                  onTapSelected: onTabSelected,
                  selectedTab: selectedTab,
                ),
                Expanded(
                  child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      onPageChanged: onTabSelected,
                      itemCount: meals.last.planDays.length,
                      itemBuilder: (context, index) {
                        final planDay = meals.last.planDays[index];
                        return Padding(
                          padding: AppConstants.padding16,
                          child: KeepAliveWidget(child: _buildPage(planDay)),
                        );
                      }),
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
        physics: BouncingScrollPhysics(),
        child: Column(
          spacing: 20,
          children: [
            // Text(
            //   //"وجبات اليوم بتاريخ ${DateFormat("dd/MM/yyyy").format(DateTime.now())}",
            //   "وجبات ${planDay.day.displayName}",
            //   style: context.tt.titleLarge?.copyWith(color: context.cs.primary),
            //   textAlign: TextAlign.center,
            // ),
            ...List.generate(planDay.meals.length, (index) {
              final meal = planDay.meals[index];
              return _buildMealItem(meal);
            }),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }

  Widget _buildMealItem(MealModel meal) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  meal.name,
                  style: context.tt.titleLarge?.copyWith(
                    color: context.cs.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...meal.ingredients.map((ingredientWithQnt) {
              final ingredient = ingredientWithQnt.ingredient;
              return Container(
                margin: AppConstants.paddingV10,
                padding: AppConstants.padding12,
                decoration: BoxDecoration(
                  color: context.cs.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ingredient.name,
                      style: context.tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutrient(
                          icon: Icons.local_drink,
                          label: "الكمية",
                          value: ingredientWithQnt.quantity.toString(),
                        ),
                        _buildNutrient(
                          icon: Icons.local_fire_department,
                          label: "السعرات",
                          value: ingredient.calories,
                        ),
                        _buildNutrient(
                          icon: Icons.fitness_center,
                          label: "البروتين",
                          value: ingredient.proteins,
                        ),
                        _buildNutrient(
                          icon: Icons.bubble_chart,
                          label: "الكربوهيدرات",
                          value: ingredient.carbs,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: AppConstants.paddingH20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("طريقة التحضير :", style: context.tt.titleLarge),
                      Icon(Icons.play_circle, color: context.cs.error)
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(meal.description, style: context.tt.bodyMedium),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNutrient({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blueAccent),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
