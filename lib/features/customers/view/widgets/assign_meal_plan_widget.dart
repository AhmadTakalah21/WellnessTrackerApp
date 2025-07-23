import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

class AssignMealPlanView extends StatelessWidget {
  const AssignMealPlanView({
    super.key,
    required this.customersCubit,
    required this.onSave,
  });

  final CustomersCubit customersCubit;
  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: customersCubit),
        BlocProvider(create: (context) => get<MealPlansCubit>()),
      ],
      child: AssignMealPlanWidget(
        customersCubit: customersCubit,
        onSave: onSave,
      ),
    );
  }
}

class AssignMealPlanWidget extends StatefulWidget {
  const AssignMealPlanWidget({
    super.key,
    required this.customersCubit,
    required this.onSave,
  });
  final CustomersCubit customersCubit;
  final void Function() onSave;

  @override
  State<AssignMealPlanWidget> createState() => _AssignMealPlanWidgetState();
}

class _AssignMealPlanWidgetState extends State<AssignMealPlanWidget> {
  late final MealPlansCubit mealPlansCubit = context.read();

  @override
  void initState() {
    super.initState();
    mealPlansCubit.getMealPlans(UserRoleEnum.dietitian);
  }

  void onTryAgainTap() => mealPlansCubit.getMealPlans(UserRoleEnum.dietitian);

  @override
  void dispose() {
    widget.customersCubit.resetAssignMealPlanModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        padding: AppConstants.padding16,
        child: Column(
          spacing: 20,
          children: [
            Row(
              children: [
                Spacer(),
                SizedBox(width: 16),
                Text(
                  "assign_meal_plan".tr(),
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: AppColors.greyShade),
                ),
              ],
            ),
            BlocBuilder<MealPlansCubit, GeneralMealPlansState>(
              builder: (context, state) {
                if (state is MealPlansLoading) {
                  return LoadingIndicator();
                } else if (state is MealPlansSuccess) {
                  return MainDropDownWidget(
                    items: state.mealPlans.data,
                    prefixIcon: Icons.food_bank,
                    hintText: "select_meal_plan".tr(),
                    labelText: "meal_plans".tr(),
                    onChanged: widget.customersCubit.setPlanId,
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
                  return SizedBox.shrink();
                }
              },
            ),
            BlocConsumer<CustomersCubit, GeneralCustomersState>(
              listener: (context, state) {
                if (state is AssignMealPlanSuccess) {
                  Navigator.pop(context);
                  MainSnackBar.showSuccessMessage(context, state.message);
                } else if (state is AssignMealPlanFail) {
                  MainSnackBar.showErrorMessage(context, state.error);
                }
              },
              builder: (context, state) {
                bool isLoading = state is AssignMealPlanLoading;
                return MainActionButton(
                  onTap: isLoading ? () {} : () => widget.onSave(),
                  text: "save".tr(),
                  child: isLoading
                      ? LoadingIndicator(size: 20, color: context.cs.surface)
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
