import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/cubit/exercise_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/exercises/cubit/exercises_cubit.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/features/exercises/view/add_exercise_view.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/mutli_selector_drop_down.dart';

abstract class SelectExercisesForDayViewCallBacks {
  void onAddExercise();
  void onLongPress(ExerciseModel exercise);
  void onEditTap(ExerciseModel exercise);
  void onDeleteTap(ExerciseModel exercise);
  void onSave();
  void onCancel();
  void onTryAgainTap();
}

class SelectExercisesForDayView extends StatelessWidget {
  const SelectExercisesForDayView({
    super.key,
    required this.day,
    required this.exercisePlansCubit,
    required this.exercisesCubit,
  });
  final ExercisePlansCubit exercisePlansCubit;
  final ExercisesCubit exercisesCubit;
  final DayEnum day;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: exercisesCubit),
        BlocProvider.value(value: exercisePlansCubit),
      ],
      child: SelectExercisesForDayWidget(day: day),
    );
  }
}

class SelectExercisesForDayWidget extends StatefulWidget {
  const SelectExercisesForDayWidget({super.key, required this.day});
  final DayEnum day;

  @override
  State<SelectExercisesForDayWidget> createState() =>
      _SelectExercisesForDayWidgetState();
}

class _SelectExercisesForDayWidgetState
    extends State<SelectExercisesForDayWidget>
    implements SelectExercisesForDayViewCallBacks {
  late final ExercisesCubit exercisesCubit = context.read();
  late final ExercisePlansCubit exercisePlansCubit = context.read();

  @override
  void onAddExercise() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExerciseView(exercisesCubit: exercisesCubit),
      ),
    );
  }

  @override
  void onLongPress(ExerciseModel exercise) {
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      context: context,
      builder: (context) {
        return AdditionalOptionsBottomSheet(
          item: exercise,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
        );
      },
    );
  }

  @override
  void onEditTap(ExerciseModel exercise) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExerciseView(
          exercisesCubit: exercisesCubit,
          exercise: exercise,
        ),
      ),
    );
  }

  @override
  void onDeleteTap(ExerciseModel exercise) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
          item: exercise,
          onSuccess: () {
            Navigator.pop(context);
            exercisesCubit.getExercises(perPage: 1000000);
          }),
    );
  }

  @override
  void onCancel() => Navigator.pop(context);

  @override
  void onSave() {
    exercisePlansCubit.setExercisesForDayForModel(widget.day);
    Navigator.pop(context);
  }

  @override
  void onTryAgainTap() => exercisesCubit.getExercises(perPage: 10000);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width > 500 ? 500 : size.width * 0.95,
          maxHeight: size.height * 0.85,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 10),
              _buildExercisesMultiSelector(),
              const SizedBox(height: 14),
              _buildAddExerciseButton(),
              _buildMainActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        "select_exercises_for".tr(args: [widget.day.displayName]),
        style: context.tt.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.t.primaryColorDark,
        ),
      ),
    );
  }

  Widget _buildExercisesMultiSelector() {
    return BlocBuilder<ExercisesCubit, GeneralExercisesState>(
      buildWhen: (previous, current) => current is ExercisesState,
      builder: (context, state) {
        if (state is ExercisesLoading) {
          return LoadingIndicator();
        } else if (state is ExercisesSuccess) {
          return MutliSelectorDropDown(
            items: state.exercises.data,
            prefixIcon: Icons.subscriptions,
            hintText: "exercises".tr(),
            labelText: "exercises".tr(),
            onLongPress: onLongPress,
            onChanged: (value) => exercisePlansCubit.setExercisesForDay(value),
          );
        } else if (state is ExercisesEmpty) {
          return MainErrorWidget(
            error: state.message,
            onTryAgainTap: onTryAgainTap,
            isRefresh: true,
          );
        } else if (state is ExercisesFail) {
          return MainErrorWidget(
            error: state.error,
            onTryAgainTap: onTryAgainTap,
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildAddExerciseButton() {
    return TextButton.icon(
      onPressed: onAddExercise,
      icon: const Icon(Icons.add, color: Colors.teal),
      label: Text(
        "add_exercise".tr(),
        style: const TextStyle(color: Colors.teal),
      ),
    );
  }

  Widget _buildMainActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: MainActionButton(
            onTap: onCancel,
            text: "cancel".tr(),
            textColor: context.cs.primary,
            buttonColor: context.cs.surface,
            icon: Icon(Icons.close, color: context.cs.primary),
            shadow: AppColors.secondShadow,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: MainActionButton(onTap: onSave, text: "save".tr()))
      ],
    );
  }
}
