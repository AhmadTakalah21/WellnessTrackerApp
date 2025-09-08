import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/meal_plans/cubit/meal_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/meal_plans/model/meal_plan_model/meal_plan_model.dart';
import 'package:wellnesstrackerapp/features/meal_plans/view/add_meal_plans.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

abstract class AssignMealPlanViewCallBacks {
  void onAddMealPlanTap();
  void onLongPress(MealPlanModel mealPlan);
  void onEditTap(MealPlanModel mealPlan);
  void onDeleteTap(MealPlanModel mealPlan);
  void onTryAgainTap();
}

class AssignMealPlanView extends StatelessWidget {
  const AssignMealPlanView({super.key, required this.customersCubit});

  final CustomersCubit customersCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: customersCubit),
        BlocProvider(create: (context) => get<MealPlansCubit>()),
      ],
      child: AssignMealPlanWidget(customersCubit: customersCubit),
    );
  }
}

class AssignMealPlanWidget extends StatefulWidget {
  const AssignMealPlanWidget({super.key, required this.customersCubit});
  final CustomersCubit customersCubit;

  @override
  State<AssignMealPlanWidget> createState() => _AssignMealPlanWidgetState();
}

class _AssignMealPlanWidgetState extends State<AssignMealPlanWidget>
    implements AssignMealPlanViewCallBacks {
  late final MealPlansCubit mealPlansCubit = context.read();

  @override
  void initState() {
    super.initState();
    mealPlansCubit.getMealPlans(UserRoleEnum.dietitian, perPage: 100000);
  }

  @override
  void onLongPress(MealPlanModel mealPlan) {
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      context: context,
      builder: (context) {
        return AdditionalOptionsBottomSheet(
          item: mealPlan,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
        );
      },
    );
  }

  @override
  void onEditTap(MealPlanModel mealPlan) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMealPlanView(
              mealPlansCubit: mealPlansCubit, mealPlan: mealPlan),
        ));
  }

  @override
  void onDeleteTap(MealPlanModel mealPlan) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
          item: mealPlan,
          onSuccess: () {
            Navigator.pop(context);
            mealPlansCubit.getMealPlans(
              UserRoleEnum.dietitian,
              perPage: 100000,
            );
          }),
    );
  }

  @override
  void onAddMealPlanTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMealPlanView(mealPlansCubit: mealPlansCubit),
      ),
    );
  }

  void onSave() => widget.customersCubit.assignMealPlan();

  @override
  void onTryAgainTap() =>
      mealPlansCubit.getMealPlans(UserRoleEnum.dietitian, perPage: 100000);

  @override
  void dispose() {
    widget.customersCubit.resetAssignPlanModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadius15),
      insetPadding: AppConstants.padding24,
      child: Container(
        padding: AppConstants.padding24,
        constraints: const BoxConstraints(minWidth: 400, maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildMealPlansDropDown(),
                const SizedBox(width: 20),
                _buildAddMealPlanButton(),
              ],
            ),
            const SizedBox(height: 32),
            _buildMainActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        SizedBox(width: 30),
        Expanded(
          child: Text(
            "assign_meal_plan".tr(),
            style: context.tt.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: AppColors.greyShade),
        ),
      ],
    );
  }

  Widget _buildMealPlansDropDown() {
    return BlocBuilder<MealPlansCubit, GeneralMealPlansState>(
      buildWhen: (previous, current) => current is MealPlansState,
      builder: (context, state) {
        if (state is MealPlansLoading) {
          return const Center(child: LoadingIndicator());
        } else if (state is MealPlansSuccess) {
          return Expanded(
            child: MainDropDownWidget(
              items: state.mealPlans.data,
              prefixIcon: Icons.food_bank,
              hintText: "select_meal_plan".tr(),
              labelText: "meal_plans".tr(),
              onLongPress: onLongPress,
              onChanged: (plan) => widget.customersCubit.setPlanId(plan?.id),
            ),
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
    );
  }

  Widget _buildAddMealPlanButton() {
    return InkWell(
      onTap: onAddMealPlanTap,
      child: Container(
        padding: AppConstants.padding18,
        decoration: BoxDecoration(
          borderRadius: AppConstants.borderRadius12,
          color: context.cs.primary,
        ),
        child: Icon(Icons.add, color: context.cs.surface, size: 24),
      ),
    );
  }

  Widget _buildMainActionButton() {
    return BlocConsumer<CustomersCubit, GeneralCustomersState>(
      listener: (context, state) {
        if (state is AssignPlanSuccess) {
          Navigator.pop(context);
          MainSnackBar.showSuccessMessage(context, state.message);
        } else if (state is AssignPlanFail) {
          MainSnackBar.showErrorMessage(context, state.error);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: MainActionButton(
            onTap: onSave,
            text: "save".tr(),
            isLoading: state is AssignPlanLoading,
          ),
        );
      },
    );
  }
}
