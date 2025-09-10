import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wellnesstrackerapp/features/exercise_plans/cubit/exercise_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_day_model/exercise_plan_day_model.dart';
import 'package:wellnesstrackerapp/features/exercises/view/widgets/exercise_tile.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/keep_alive_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_tab_bar.dart';

abstract class ExercisesViewCallbacks {
  void onTabSelected(int index);
  void onTryAgainTap();
  Future<void> onRefresh();
}

@RoutePage()
class ExercisesView extends StatelessWidget {
  const ExercisesView({super.key, required this.role});
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<ExercisePlansCubit>(),
      child: ExercisesPage(role: role),
    );
  }
}

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key, required this.role});
  final UserRoleEnum role;

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage>
    with TickerProviderStateMixin
    implements ExercisesViewCallbacks {
  late final ExercisePlansCubit exercisePlansCubit = context.read();
  PageController pageController = PageController();
  TabController? tabController;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    exercisePlansCubit.getExercisePlans(widget.role);
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => exercisePlansCubit.getExercisePlans(widget.role);

  @override
  void onTabSelected(int index) {
    setState(() => selectedTab = index);
    tabController?.animateTo(index);
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('exercises'.tr())),
      body: BlocConsumer<ExercisePlansCubit, GeneralExercisePlansState>(
        buildWhen: (previous, current) => current is ExercisePlansState,
        listener: (context, state) {
          if (state is ExercisePlansSuccess) {
            final planDays = state.exercisePlans.data.last.planDays;
            final titles = planDays.map((e) => e.day.displayName).toList();
            tabController?.dispose();
            tabController = TabController(length: titles.length, vsync: this);
          }
        },
        builder: (context, state) {
          if (state is ExercisePlansLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is ExercisePlansSuccess) {
            final planDays = state.exercisePlans.data.last.planDays;
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
                      return Padding(
                        padding: AppConstants.padding16,
                        child: KeepAliveWidget(child: _buildPage(planDay)),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is ExercisePlansEmpty) {
            return MainErrorWidget(
              error: state.message,
              isRefresh: true,
              onTryAgainTap: onTryAgainTap,
            );
          } else if (state is ExercisePlansFail) {
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

  Widget _buildPage(ExercisePlanDayModel planDay) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        padding: AppConstants.paddingH10,
        physics: const BouncingScrollPhysics(),
        child: Column(
          spacing: 20,
          children: [
            ...planDay.exercises
                .map((exercise) => ExerciseTile(exercise: exercise)),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
