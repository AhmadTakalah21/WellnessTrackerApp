import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/cubit/exercise_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_day_model/exercise_plan_day_model.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
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
  late TabController tabController;
  int selectedTab = 0;

  // final List<String> tabBarTitles =
  //     DayEnum.values.map((day) => day.displayName).toList();

  @override
  void initState() {
    super.initState();
    exercisePlansCubit.getExercisePlans(widget.role);
    // tabController = TabController(length: tabBarTitles.length, vsync: this);
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => exercisePlansCubit.getExercisePlans(widget.role);

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
        title: Text('exercises'.tr(), style: context.tt.titleLarge),
      ),
      body: BlocBuilder<ExercisePlansCubit, GeneralExercisePlansState>(
        buildWhen: (previous, current) => current is ExercisePlansState,
        builder: (context, state) {
          if (state is ExercisePlansLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is ExercisePlansSuccess) {
            final exercises = state.exercisePlans.data;
            final tabBarTitles =
                exercises.last.planDays.map((e) => e.day.displayName).toList();
            tabController =
                TabController(length: tabBarTitles.length, vsync: this);
            return Column(
              children: [
                MainTabBar(
                  //titles: tabBarTitles,
                  titles: exercises.last.planDays
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
                      itemCount: exercises.last.planDays.length,
                      itemBuilder: (context, index) {
                        final planDay = exercises.last.planDays[index];
                        return Padding(
                          padding: AppConstants.padding16,
                          child: KeepAliveWidget(child: _buildPage(planDay)),
                        );
                      }),
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
      // body: Padding(
      //   padding: AppConstants.padding16,
      //   child: SingleChildScrollView(
      //     physics: BouncingScrollPhysics(),
      //     child: Column(
      //       spacing: 20,
      //       children: [
      //         _buildTitle(),
      //         ...exercises.map((exercise) => _buildExerciseTile(exercise)),
      //         SizedBox(height: 100),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildPage(ExercisePlanDayModel planDay) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        padding: AppConstants.paddingH10,
        physics: BouncingScrollPhysics(),
        child: Column(
          spacing: 20,
          children: [
           // _buildTitle(),
            ...List.generate(planDay.exercises.length, (index) {
              final exercise = planDay.exercises[index];
              return _buildExerciseTile(exercise);
            }),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }

  // Widget _buildTitle() {
  //   return Center(
  //     child: Text(
  //       "تمارين اليوم بتاريخ ${DateFormat("dd/MM/yyyy").format(DateTime.now())}",
  //       style: context.tt.titleLarge?.copyWith(color: context.cs.primary),
  //       textAlign: TextAlign.center,
  //     ),
  //   );
  // }

  Widget _buildExerciseTile(ExerciseModel exercise) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(exercise.name, style: context.tt.bodyLarge),
        subtitle: Padding(
          padding: AppConstants.padding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exercise.description.rounds.toString(),
                style: context.tt.bodySmall?.copyWith(color: Colors.grey),
              ),
              Text(
                exercise.description.repeats.toString(),
                style: context.tt.bodySmall?.copyWith(color: Colors.grey),
              ),
              Text(
                exercise.description.explain,
                style: context.tt.bodySmall?.copyWith(color: Colors.grey),
              ),
              Row(
                children: [
                  Text(
                    "اضغط هنا لمشاهدة كيفية أداء التمرين",
                    style: context.tt.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.play_circle, color: context.cs.error)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
