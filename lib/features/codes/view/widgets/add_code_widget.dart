import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/codes/cubit/codes_cubit.dart';
import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
import 'package:wellnesstrackerapp/features/codes/model/department_model/department_model.dart';
import 'package:wellnesstrackerapp/global/models/activity_status_enum.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_date_picker.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class AddCodeWidget extends StatefulWidget {
  final bool isEdit;
  final CodeModel? code;
  final VoidCallback? onSuccess;

  const AddCodeWidget({
    super.key,
    required this.isEdit,
    this.code,
    this.onSuccess,
  });

  @override
  State<AddCodeWidget> createState() => _AddCodeWidgetState();
}

class _AddCodeWidgetState extends State<AddCodeWidget> {
  late final CodesCubit codesCubit = context.read();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  DepartmentModel? selectedDepartment;
  ActivityStatusEnum? selectedStatus;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.code != null) {
      codeController.text = widget.code!.code;
      startDateController.text = widget.code!.startDate;
      endDateController.text = widget.code!.endDate;
      //selectedStatus = widget.code!.status;
      selectedDepartment = widget.code!.department;
    }
  }

  void onStartDateSelected() {
    // TODO
  }

  void onEndDateSelected() {
    // TODO
  }

  void onSave() {
    // TODO
   // if (!_formKey.currentState!.validate()) return;
    // Call the cubit method to add/update
    // codesCubit.submitCode(
    //   code: codeModel,
    //   isEdit: widget.isEdit,
    //   onSuccess: widget.onSuccess,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: AppConstants.padding20,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  widget.isEdit ? 'edit_code'.tr() : 'add_code'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 16),
              MainTextField2(
                icon: Icons.qr_code,
                controller: codeController,
                label: 'code'.tr(),
                validator: (val) =>
                    val == null || val.isEmpty ? 'required_field'.tr() : null,
              ),
              const SizedBox(height: 12),
              MainDatePicker(
                label: "start_date",
                onDateSelected: onStartDateSelected,
              ),
              const SizedBox(height: 12),
              MainDatePicker(
                label: "end_date",
                onDateSelected: onEndDateSelected,
              ),
              const SizedBox(height: 12),
              // TODO change this
              MainDropDownWidget(
                items: ActivityStatusEnum.values,
                prefixIcon: Icons.abc,
                hintText: "hintText",
                labelText: "labelText",
                errorMessage: "errorMessage",
                onChanged: (val) => setState(() => selectedStatus = val),
              ),
              const SizedBox(height: 30),
              MainActionButton(
                text: widget.isEdit ? 'update'.tr() : 'save'.tr(),
                onTap: onSave,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
