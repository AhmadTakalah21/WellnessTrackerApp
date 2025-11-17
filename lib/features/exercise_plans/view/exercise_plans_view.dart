import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/cubit/exercise_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_model/exercise_plan_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/view/add_exercise_plan_view.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/animations/tile_slide_animation.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class ExercisePlansViewCallBacks {
  void fetchData();
  void onTap(ExercisePlanModel plan);
  void onEditTap(ExercisePlanModel? plan);
  void onDeleteTap(ExercisePlanModel plan);
  void onTryAgainTap();
  Future<void> onRefresh();
}

@RoutePage()
class ExercisePlansView extends StatelessWidget {
  const ExercisePlansView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<ExercisePlansCubit>(),
      child: const ExercisePlansPage(),
    );
  }
}

class ExercisePlansPage extends StatefulWidget {
  const ExercisePlansPage({super.key});

  @override
  State<ExercisePlansPage> createState() => _ExercisePlansPageState();
}

class _ExercisePlansPageState extends State<ExercisePlansPage>
    implements ExercisePlansViewCallBacks {
  late final ExercisePlansCubit exercisePlansCubit = context.read();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void fetchData() => exercisePlansCubit.getExercisePlans(UserRoleEnum.coach);

  @override
  void onTap(ExercisePlanModel plan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (context) => AdditionalOptionsBottomSheet(
        item: plan,
        onEditTap: onEditTap,
        onDeleteTap: onDeleteTap,
      ),
    );
  }

  @override
  void onDeleteTap(ExercisePlanModel plan) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
        item: plan,
        onSuccess: () => fetchData(),
      ),
    );
  }

  @override
  void onEditTap(ExercisePlanModel? plan) {
    if (plan != null) Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExercisePlanView(
            exercisePlansCubit: exercisePlansCubit, exercisePlan: plan),
      ),
    );
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => fetchData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("exercise_plans".tr())),
      body: BlocBuilder<ExercisePlansCubit, GeneralExercisePlansState>(
        buildWhen: (previous, current) => current is ExercisePlansState,
        builder: (context, state) {
          if (state is ExercisePlansLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is ExercisePlansSuccess) {
            final plans = state.exercisePlans.data;
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                padding: AppConstants.padding20,
                physics: BouncingScrollPhysics(),
                child: Column(
                  spacing: 20,
                  children: [
                    ...plans.asMap().entries.map((plan) {
                      return TileSlideAnimation(
                        index: plan.key,
                        child: _buildTile(plan.key, plan.value),
                      );
                    }),
                    if (plans.length < 10)
                      SizedBox(height: (10 - plans.length) * 100.0),
                    SizedBox(height: 100)
                  ],
                ),
              ),
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
      floatingActionButton: MainFloatingButton(onTap: () => onEditTap(null)),
    );
  }

  Widget _buildTile(int index, ExercisePlanModel plan) {
    return InkWell(
      onTap: () => onTap(plan),
      child: Card(
        elevation: 6,
        shape:
            RoundedRectangleBorder(borderRadius: AppConstants.borderRadius15),
        child: ListTile(
          minVerticalPadding: 8,
          dense: true,
          visualDensity: VisualDensity.compact,
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.cs.primary,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: AppConstants.padding16,
                  child: Text(
                    "${index + 1}",
                    style: context.tt.headlineSmall,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  plan.name,
                  style: context.tt.headlineSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
