import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_counter_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class AddCustomerReportView extends StatelessWidget {
  const AddCustomerReportView({
    super.key,
    required this.customersCubit,
    required this.role,
    required this.customer,
  });

  final CustomersCubit customersCubit;
  final UserRoleEnum role;
  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: customersCubit,
      child: _AddCustomerReportWidget(
        role: role,
        customersCubit: customersCubit,
        customer: customer,
      ),
    );
  }
}

class _AddCustomerReportWidget extends StatefulWidget {
  const _AddCustomerReportWidget({
    required this.role,
    required this.customersCubit,
    required this.customer,
  });
  final UserRoleEnum role;
  final CustomersCubit customersCubit;
  final CustomerModel customer;

  @override
  State<_AddCustomerReportWidget> createState() =>
      __AddCustomerReportWidgetState();
}

class __AddCustomerReportWidgetState extends State<_AddCustomerReportWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    widget.customersCubit.resetEvaluateCustomerModel();
    super.dispose();
  }

  void onSave() {
    if (_formKey.currentState!.validate()) {
      widget.customersCubit.evaluateSubscriber(widget.role, widget.customer.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.padding16,
      child: SingleChildScrollView(
        padding: MediaQuery.of(context).viewInsets,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              const SizedBox.shrink(),
              Text(
                "subscriber_evaluation".tr(),
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              MainTextField2(
                onChanged: widget.customersCubit.setHealth,
                icon: Icons.health_and_safety_outlined,
                label: 'health_evaluate'.tr(),
                validator: (val) =>
                    Utils.validateInput(val, InputTextType.none),
              ),
              MainTextField2(
                onChanged: widget.customersCubit.setPsychology,
                icon: Icons.psychology_outlined,
                label: 'psychology_evaluate'.tr(),
                validator: (val) =>
                    Utils.validateInput(val, InputTextType.none),
              ),
              MainTextField2(
                onChanged: widget.customersCubit.setBehavior,
                icon: Icons.accessibility_new,
                label: 'behavior_evaluate'.tr(),
                validator: (val) =>
                    Utils.validateInput(val, InputTextType.none),
              ),
              MainCounterWidget(
                onChanged: widget.customersCubit.setPlansCount,
                label: 'plans_count'.tr(),
                icon: Icons.list_alt,
                isRequired: true,
              ),
              BlocConsumer<CustomersCubit, GeneralCustomersState>(
                listener: (context, state) {
                  if (state is EvaluateSubscriberSuccess) {
                    Navigator.pop(context);
                    MainSnackBar.showSuccessMessage(context, state.message);
                  } else if (state is EvaluateSubscriberFail) {
                    MainSnackBar.showErrorMessage(context, state.error);
                  }
                },
                builder: (context, state) {
                  bool isLoading = state is EvaluateSubscriberLoading;
                  return MainActionButton(
                    onTap: isLoading ? () {} : onSave,
                    text: "save".tr(),
                    child: isLoading
                        ? LoadingIndicator(size: 20, color: context.cs.surface)
                        : null,
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
