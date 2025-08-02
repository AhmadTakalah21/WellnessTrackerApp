import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/meal_plans/view/widget/add_meal_dialog.dart';
import 'package:wellnesstrackerapp/features/meals/cubit/meals_cubit.dart';
import 'package:wellnesstrackerapp/features/meals/model/meal_model/meal_model.dart';
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

abstract class SelectMealsForDayWidgetCallBacks {
  void onAddMeal();
  void onLongPress(MealModel meal);
  void onEditTap(MealModel meal);
  void onDeleteTap(MealModel meal);
  void onSave();
  void onCancel();
  void onTryAgainTap();
}

class SelectMealsForDayWidget extends StatelessWidget {
  const SelectMealsForDayWidget({
    super.key,
    required this.day,
    required this.mealPlansCubit,
    required this.mealsCubit,
  });
  final MealPlansCubit mealPlansCubit;
  final MealsCubit mealsCubit;
  final DayEnum day;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: mealsCubit),
        BlocProvider.value(value: mealPlansCubit),
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
    implements SelectMealsForDayWidgetCallBacks {
  late final MealsCubit mealsCubit = context.read();
  late final MealPlansCubit mealPlansCubit = context.read();

  @override
  void onAddMeal() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMealView(mealsCubit: mealsCubit),
      ),
    );
  }

  @override
  void onLongPress(MealModel meal) {
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      context: context,
      builder: (context) {
        return AdditionalOptionsBottomSheet(
          item: meal,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
        );
      },
    );
  }

  @override
  void onEditTap(MealModel meal) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMealView(mealsCubit: mealsCubit, meal: meal),
      ),
    );
  }

  @override
  void onDeleteTap(MealModel meal) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
          item: meal,
          onSuccess: () {
            Navigator.pop(context);
            mealsCubit.getMeals(perPage: 10000);
          }),
    );
  }

  @override
  void onCancel() => Navigator.pop(context);

  @override
  void onSave() {
    mealPlansCubit.setMealsForDayForModel(widget.day);
    Navigator.pop(context);
  }

  @override
  void onTryAgainTap() => mealsCubit.getMeals(perPage: 10000);

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
              _buildMealsMultiSelector(),
              const SizedBox(height: 14),
              _buildAddMealButton(),
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

  Widget _buildMealsMultiSelector() {
    return BlocBuilder<MealsCubit, GeneralMealsState>(
      buildWhen: (previous, current) => current is MealsState,
      builder: (context, state) {
        if (state is MealsLoading) {
          return LoadingIndicator();
        } else if (state is MealsSuccess) {
          return MutliSelectorDropDown(
            items: state.meals.data,
            prefixIcon: Icons.subscriptions,
            hintText: "meals".tr(),
            labelText: "meals".tr(),
            onLongPress: onLongPress,
            onChanged: (value) => mealPlansCubit.setMealsForDay(value),
          );
        } else if (state is MealsEmpty) {
          return MainErrorWidget(
            error: state.message,
            onTryAgainTap: onTryAgainTap,
            isRefresh: true,
          );
        } else if (state is MealsFail) {
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

  Widget _buildAddMealButton() {
    return TextButton.icon(
      onPressed: onAddMeal,
      icon: const Icon(Icons.add, color: Colors.teal),
      label: Text(
        "add_meal".tr(),
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
