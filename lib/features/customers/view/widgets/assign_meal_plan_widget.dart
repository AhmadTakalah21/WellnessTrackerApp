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

import '../../../meal_plans/view/add_meal_plans.dart';

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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(minWidth: 400, maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "assign_meal_plan".tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.greyShade),
                ),
              ],
            ),
            const SizedBox(height: 24),
            BlocBuilder<MealPlansCubit, GeneralMealPlansState>(
              builder: (context, state) {
                if (state is MealPlansLoading) {
                  return const Center(child: LoadingIndicator());
                } else if (state is MealPlansSuccess) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: MainDropDownWidget(
                          items: state.mealPlans.data,
                          prefixIcon: Icons.food_bank,
                          hintText: "select_meal_plan".tr(),
                          labelText: "meal_plans".tr(),
                          onChanged: widget.customersCubit.setPlanId,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Tooltip(
                        message: "add_meal_plan".tr(),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => const AddMealPlanDialog(),
                            ).then((_) {
                              mealPlansCubit.getMealPlans(UserRoleEnum.dietitian);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.secondaryColor,
                            ),
                            child: const Icon(Icons.add, color: Colors.white, size: 24),
                          ),
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
            const SizedBox(height: 32),
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
                final isLoading = state is AssignMealPlanLoading;
                return SizedBox(
                  width: double.infinity,
                  child: MainActionButton(
                    onTap: isLoading ? () {} : () => widget.onSave(),
                    text: "save".tr(),
                    child: isLoading
                        ? LoadingIndicator(size: 20, color: context.cs.surface)
                        : null,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



