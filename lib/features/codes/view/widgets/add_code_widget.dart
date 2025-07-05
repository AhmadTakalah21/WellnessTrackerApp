import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/codes/cubit/codes_cubit.dart';
import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_date_picker.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class AddCodeWidget extends StatefulWidget {
  const AddCodeWidget({
    super.key,
    required this.isEdit,
    this.code,
    this.onSuccess,
    required this.codesCubit,
  });

  final CodesCubit codesCubit;
  final bool isEdit;
  final CodeModel? code;
  final VoidCallback? onSuccess;

  @override
  State<AddCodeWidget> createState() => _AddCodeWidgetState();
}

class _AddCodeWidgetState extends State<AddCodeWidget> {
  late final CodesCubit codesCubit = context.read();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final code = widget.code;
    if (widget.isEdit && code != null) {
      widget.codesCubit.setCode(code.code);
      widget.codesCubit.setStartDate(code.startDate);
      widget.codesCubit.setEndDate(code.endDate);
      // widget.codesCubit.setDepartment(DepartmentEnum.getDepartmentById(
      //   code.department.id,
      // ));
    }
  }

  void onCancelTap() => Navigator.pop(context);

  String? _formattedDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    return DateFormat("yyyy-MM-dd").format(date);
  }

  void onCodeChanged(String code) => widget.codesCubit.setCode(code);

  void onStartDateSelected(DateTime? date) =>
      widget.codesCubit.setStartDate(_formattedDate(date));

  void onEndDateSelected(DateTime? date) =>
      widget.codesCubit.setEndDate(_formattedDate(date));

  // void onDepartmentSelected(DepartmentEnum? department) =>
  //     widget.codesCubit.setDepartment(department);

  void onSave() => widget.codesCubit.addCode(isAdd: !widget.isEdit);

  @override
  Widget build(BuildContext context) {
    // final selectedDepartment = DepartmentEnum.values.firstWhereOrNull(
    //   (department) => department.id == widget.code?.department.id,
    // );
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
                initialText: widget.code?.code,
                onChanged: onCodeChanged,
                icon: Icons.qr_code,
                label: 'code'.tr(),
                validator: (val) =>
                    val == null || val.isEmpty ? 'required_field'.tr() : null,
              ),
              const SizedBox(height: 12),
              MainDatePicker(
                isStart: true,
                initialDate: widget.code?.startDate,
                onDateSelected: onStartDateSelected,
              ),
              const SizedBox(height: 12),
              MainDatePicker(
                isEnd: true,
                initialDate: widget.code?.endDate,
                onDateSelected: onEndDateSelected,
              ),
              // const SizedBox(height: 12),
              // MainDropDownWidget(
              //   items: DepartmentEnum.values,
              //   prefixIcon: Icons.group,
              //   hintText: "department".tr(),
              //   labelText: "department".tr(),
              //   errorMessage: "department_required".tr(),
              //   onChanged: onDepartmentSelected,
              //   // selectedValue: selectedDepartment,
              // ),
              const SizedBox(height: 30),
              BlocConsumer<CodesCubit, GeneralCodesState>(
                bloc: widget.codesCubit,
                listener: (context, state) {
                  if (state is AddCodeSuccess) {
                    widget.onSuccess?.call();
                    onCancelTap();
                    MainSnackBar.showSuccessMessage(context, state.message);
                  } else if (state is AddCodeFail) {
                    MainSnackBar.showErrorMessage(context, state.error);
                  }
                },
                builder: (context, state) {
                  var onTap = onSave;
                  Widget? child;
                  if (state is AddCodeLoading) {
                    onTap = () {};
                    child = const LoadingIndicator(size: 30);
                  }
                  return MainActionButton(
                    text: widget.isEdit ? 'update'.tr() : 'save'.tr(),
                    onTap: onTap,
                    child: child,
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
