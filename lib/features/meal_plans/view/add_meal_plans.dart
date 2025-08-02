import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/plan_day_item_model/plan_day_item_to_show_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/view/widget/select_meals_for_day_widget.dart';
import 'package:wellnesstrackerapp/features/meals/cubit/meals_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/day_enum.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class AddMealPlanViewCallBacks {
  void onDayTap(DayEnum day);
  void onSave();
}

@RoutePage()
class AddMealPlanView extends StatelessWidget {
  const AddMealPlanView({
    super.key,
    required this.mealPlansCubit,
    this.mealPlan,
  });
  final MealPlansCubit mealPlansCubit;
  final MealPlanModel? mealPlan;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: mealPlansCubit),
        BlocProvider(create: (context) => get<MealsCubit>()),
      ],
      child: AddMealPlanPage(mealPlan: mealPlan),
    );
  }
}

class AddMealPlanPage extends StatefulWidget {
  const AddMealPlanPage({super.key, required this.mealPlan});
  final MealPlanModel? mealPlan;

  @override
  State<AddMealPlanPage> createState() => _AddMealPlanPageState();
}

class _AddMealPlanPageState extends State<AddMealPlanPage>
    implements AddMealPlanViewCallBacks {
  late final MealPlansCubit mealPlansCubit = context.read();
  late final MealsCubit mealsCubit = context.read();

  @override
  void initState() {
    mealPlansCubit.setModel(widget.mealPlan);
    mealPlansCubit.getPlanDays();
    mealsCubit.getMeals(perPage: 100000);
    super.initState();
  }

  @override
  void onDayTap(DayEnum day) {
    showDialog(
      context: context,
      builder: (_) => SelectMealsForDayWidget(
        day: day,
        mealPlansCubit: mealPlansCubit,
        mealsCubit: mealsCubit,
      ),
    );
  }

  @override
  void onSave() => mealPlansCubit.addMealPlan(id: widget.mealPlan?.id);

  @override
  void dispose() {
    mealPlansCubit.resetModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mealPlan = widget.mealPlan;
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNameTextField(mealPlan),
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

  PreferredSizeWidget _buildAppBar() {
    return MainAppBar(
      title: "add_meal_plan".tr(),
      automaticallyImplyLeading: true,
      hasLogout: false,
    );
  }

  Widget _buildNameTextField(MealPlanModel? mealPlan) {
    return MainTextField2(
      initialText: mealPlan?.name,
      onChanged: mealPlansCubit.setName,
      validator: (val) => Utils.validateInput(val, InputTextType.none),
      icon: Icons.edit_note_outlined,
      label: "meal_plan_name".tr(),
    );
  }

  Widget _buildTitle() {
    return Text(
      "choose_meal_days".tr(),
      style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPlanDays() {
    return BlocBuilder<MealPlansCubit, GeneralMealPlansState>(
      buildWhen: (previous, current) => current is MealPlanDaysState,
      builder: (context, state) {
        if (state is MealPlanDaysState) {
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

  Widget _buildPlanDayTile(PlanDayItemToShowModel planDay) {
    final day = planDay.day;
    final names = planDay.meals.map((e) => e.name).join(" - ");
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
                      "${"meals_selected".tr()} $names",
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
    return BlocConsumer<MealPlansCubit, GeneralMealPlansState>(
      listener: (context, state) {
        if (state is AddMealPlanSuccess) {
          Navigator.pop(context);
          mealPlansCubit.getMealPlans(UserRoleEnum.dietitian);
          MainSnackBar.showSuccessMessage(context, state.message);
        } else if (state is AddMealPlanFail) {
          MainSnackBar.showErrorMessage(context, state.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is AddMealPlanLoading;
        return MainActionButton(
          onTap: isLoading ? () {} : onSave,
          text: "save".tr(),
          child: isLoading ? LoadingIndicator() : null,
        );
      },
    );
  }
}
