import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/cubit/exercise_plans_cubit.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/model/exercise_plan_model/exercise_plan_model.dart';
import 'package:wellnesstrackerapp/features/exercise_plans/view/add_exercise_plan_view.dart';
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

abstract class AssignExercisePlanViewCallBacks {
  void onAddExercisePlanTap();
  void onLongPress(ExercisePlanModel exercisePlan);
  void onEditTap(ExercisePlanModel exercisePlan);
  void onDeleteTap(ExercisePlanModel exercisePlan);
  void onTryAgainTap();
}

class AssignExercisePlanView extends StatelessWidget {
  const AssignExercisePlanView({
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
        BlocProvider(create: (context) => get<ExercisePlansCubit>()),
      ],
      child: AssignExercisePlanWidget(
        customersCubit: customersCubit,
        onSave: onSave,
      ),
    );
  }
}

class AssignExercisePlanWidget extends StatefulWidget {
  const AssignExercisePlanWidget({
    super.key,
    required this.customersCubit,
    required this.onSave,
  });
  final CustomersCubit customersCubit;
  final void Function() onSave;

  @override
  State<AssignExercisePlanWidget> createState() =>
      _AssignExercisePlanWidgetState();
}

class _AssignExercisePlanWidgetState extends State<AssignExercisePlanWidget>
    implements AssignExercisePlanViewCallBacks {
  late final ExercisePlansCubit exercisePlansCubit = context.read();

  @override
  void initState() {
    super.initState();
    exercisePlansCubit.getExercisePlans(UserRoleEnum.coach, perPage: 100000);
  }

  @override
  void onAddExercisePlanTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddExercisePlanView(
            exercisePlansCubit: exercisePlansCubit,
          ),
        ));
  }

  @override
  void onLongPress(ExercisePlanModel exercisePlan) {
    showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      context: context,
      builder: (context) {
        return AdditionalOptionsBottomSheet(
          item: exercisePlan,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
        );
      },
    );
  }

  @override
  void onEditTap(ExercisePlanModel exercisePlan) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddExercisePlanView(
            exercisePlansCubit: exercisePlansCubit,
            exercisePlan: exercisePlan,
          ),
        ));
  }

  @override
  void onDeleteTap(ExercisePlanModel exercisePlan) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
          item: exercisePlan,
          onSuccess: () {
            Navigator.pop(context);
            exercisePlansCubit.getExercisePlans(
              UserRoleEnum.coach,
              perPage: 100000,
            );
          }),
    );
  }

  @override
  void onTryAgainTap() =>
      exercisePlansCubit.getExercisePlans(UserRoleEnum.coach, perPage: 100000);

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
                _buildExersicePlansDropDown(),
                SizedBox(width: 20),
                _buildAddExercisePlanButton(),
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
            "assign_exercise_plan".tr(),
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

  Widget _buildExersicePlansDropDown() {
    return BlocBuilder<ExercisePlansCubit, GeneralExercisePlansState>(
      buildWhen: (previous, current) => current is ExercisePlansState,
      builder: (context, state) {
        if (state is ExercisePlansLoading) {
          return const Center(child: LoadingIndicator());
        } else if (state is ExercisePlansSuccess) {
          return Expanded(
            child: MainDropDownWidget(
              items: state.exercisePlans.data,
              prefixIcon: Icons.food_bank,
              hintText: "select_exercise_plan".tr(),
              labelText: "exercise_plans".tr(),
              onLongPress: onLongPress,
              onChanged: (plan) => widget.customersCubit.setPlanId(plan?.id),
            ),
          );
        } else if (state is ExercisePlansEmpty) {
          return MainErrorWidget(
            error: state.message,
            isRefresh: true,
            onTryAgainTap: onTryAgainTap,
          );
        } else if (state is ExercisePlansFail) {
          return Expanded(
            child: MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildAddExercisePlanButton() {
    return InkWell(
      onTap: onAddExercisePlanTap,
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
        final isLoading = state is AssignPlanLoading;
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
    );
  }
}
