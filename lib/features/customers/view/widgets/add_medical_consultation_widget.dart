import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class AddMedicalConsultationView extends StatelessWidget {
  const AddMedicalConsultationView({
    super.key,
    required this.customersCubit,
    required this.role,
    required this.customer,
  });

  final CustomersCubit customersCubit;
  final CustomerModel customer;
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: customersCubit,
      child: _AddMedicalConsultationWidget(
        customersCubit: customersCubit,
        role: role,
        customer: customer,
      ),
    );
  }
}

class _AddMedicalConsultationWidget extends StatefulWidget {
  const _AddMedicalConsultationWidget({
    required this.customersCubit,
    required this.role,
    required this.customer,
  });
  final CustomersCubit customersCubit;
  final CustomerModel customer;
  final UserRoleEnum role;

  @override
  State<_AddMedicalConsultationWidget> createState() =>
      __AddMedicalConsultationWidgetState();
}

class __AddMedicalConsultationWidgetState
    extends State<_AddMedicalConsultationWidget> {
  @override
  void dispose() {
    widget.customersCubit.resetAddMedicalConsultationModel();
    super.dispose();
  }

  void onSave() => widget.customersCubit.addMedicalConsultation(
        widget.role,
        widget.customer.id,
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: AppConstants.padding16,
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
                  "add_medical_consultation".tr(),
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
            MainTextField2(
              onChanged: widget.customersCubit.setMedicalConsultation,
              isWithTitle: false,
              label: "medical_consultation".tr(),
              icon: Icons.medical_services_outlined,
              maxLines: null,
            ),
            BlocConsumer<CustomersCubit, GeneralCustomersState>(
              listener: (context, state) {
                if (state is AddMedicalConsultationSuccess) {
                  Navigator.pop(context);
                  MainSnackBar.showSuccessMessage(context, state.message);
                } else if (state is AddMedicalConsultationFail) {
                  MainSnackBar.showErrorMessage(context, state.error);
                }
              },
              builder: (context, state) {
                return MainActionButton(
                  onTap: onSave,
                  text: "save".tr(),
                  isLoading: state is AddMedicalConsultationLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
