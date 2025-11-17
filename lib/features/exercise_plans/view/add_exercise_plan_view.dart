import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/cubit/exercise_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_day_item_model/exercise_plan_day_item_to_show_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_model/exercise_plan_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/view/widgets/select_exercises_for_day_widget.dart';
import 'package:wellnesstrackerapp/features/exercises/cubit/exercises_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class AddExercisePlanViewCallBacks {
  void onDayTap(DayEnum day);
  void onSave();
}

@RoutePage()
class AddExercisePlanView extends StatelessWidget {
  const AddExercisePlanView({
    super.key,
    required this.exercisePlansCubit,
    this.exercisePlan,
  });
  final ExercisePlansCubit exercisePlansCubit;
  final ExercisePlanModel? exercisePlan;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: exercisePlansCubit),
        BlocProvider(create: (context) => get<ExercisesCubit>()),
      ],
      child: AddExercisePlanPage(exercisePlan: exercisePlan),
    );
  }
}

class AddExercisePlanPage extends StatefulWidget {
  const AddExercisePlanPage({super.key, this.exercisePlan});
  final ExercisePlanModel? exercisePlan;

  @override
  State<AddExercisePlanPage> createState() => _AddExercisePlanPageState();
}

class _AddExercisePlanPageState extends State<AddExercisePlanPage>
    implements AddExercisePlanViewCallBacks {
  late final ExercisePlansCubit exercisePlansCubit = context.read();
  late final ExercisesCubit exercisesCubit = context.read();

  @override
  void initState() {
    print("planDays are : ${widget.exercisePlan?.planDays}");
    exercisePlansCubit.setModel(widget.exercisePlan);
    exercisePlansCubit.getPlanDays();
    exercisesCubit.getExercises(perPage: 100000);
    super.initState();
  }

  @override
  void onDayTap(DayEnum day) {
    showDialog(
      context: context,
      builder: (_) => SelectExercisesForDayView(
        exercisePlansCubit: exercisePlansCubit,
        exercisesCubit: exercisesCubit,
        day: day,
      ),
    );
  }

  @override
  void onSave() =>
      exercisePlansCubit.addExercisePlan(id: widget.exercisePlan?.id);

  @override
  void dispose() {
    exercisePlansCubit.resetModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercisePlan = widget.exercisePlan;
    final title = exercisePlan == null
        ? "add_exercise_plan".tr()
        : "edit_exercise_plan".tr();
    return Scaffold(
      appBar: _buildAppBar(title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNameTextField(exercisePlan),
            const SizedBox(height: 36),
            _buildTitle(),
            const SizedBox(height: 16),
            _buildPlanDays(),
            const SizedBox(height: 36),
            _buildMainActionButton(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String title) {
    return MainAppBar(
      title: title,
      automaticallyImplyLeading: true,
      hasLogout: false,
    );
  }

  Widget _buildNameTextField(ExercisePlanModel? exercisePlan) {
    return MainTextField2(
      initialText: exercisePlan?.name,
      onChanged: exercisePlansCubit.setName,
      validator: (val) => Utils.validateInput(val, InputTextType.none),
      icon: Icons.edit_note_outlined,
      label: "exercise_plan_name".tr(),
    );
  }

  Widget _buildTitle() {
    return Text(
      "choose_exericse_days".tr(),
      style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPlanDays() {
    return BlocBuilder<ExercisePlansCubit, GeneralExercisePlansState>(
      buildWhen: (previous, current) => current is PlanDaysState,
      builder: (context, state) {
        if (state is PlanDaysState) {
          // for (var element in state.planDays) {
          //    print(element.day);
          //   print(element.exercises);
          // }
          return Wrap(
            spacing: 18,
            runSpacing: 18,
            children: state.planDays
                .map((planDay) => _buildPlanDayTile(planDay))
                .toList(),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildPlanDayTile(ExercisePlanDayItemToShowModel planDay) {
    final day = planDay.day;
    final names = planDay.exercises.map((e) => e.name).join(" - ");
    return InkWell(
      onTap: () => onDayTap(day),
      child: Container(
        padding: AppConstants.padding16,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: AppConstants.borderRadius15,
          boxShadow: AppColors.secondShadow,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 24,
              color: Colors.teal,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "${"exercises_selected".tr()} $names",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _buildMainActionButton() {
    return BlocConsumer<ExercisePlansCubit, GeneralExercisePlansState>(
      listener: (context, state) {
        if (state is AddExercisePlanSuccess) {
          Navigator.pop(context);
          exercisePlansCubit.getExercisePlans(
            UserRoleEnum.coach,
            perPage: 100000,
          );
          MainSnackBar.showSuccessMessage(context, state.message);
        } else if (state is AddExercisePlanFail) {
          MainSnackBar.showErrorMessage(context, state.error);
        }
      },
      builder: (context, state) {
        return MainActionButton(
          onTap: onSave,
          text: "save".tr(),
          isLoading: state is AddExercisePlanLoading,
        );
      },
    );
  }
}
