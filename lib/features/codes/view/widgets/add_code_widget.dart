import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/codes/cubit/codes_cubit.dart';
import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_date_picker.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class AddCodeWidget extends StatefulWidget {
  const AddCodeWidget({
    super.key,
    this.code,
    this.onSuccess,
    required this.codesCubit,
  });

  final CodesCubit codesCubit;
  final CodeModel? code;
  final VoidCallback? onSuccess;

  @override
  State<AddCodeWidget> createState() => _AddCodeWidgetState();
}

class _AddCodeWidgetState extends State<AddCodeWidget> {
  late final CodesCubit codesCubit = context.read();

  @override
  void initState() {
    super.initState();
    final code = widget.code;
    widget.codesCubit.setModel(code);
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

  void onSave() =>
      widget.codesCubit.addCode(id: widget.code?.id);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: AppConstants.padding20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              _buildTitle(),
              const SizedBox(height: 4),
              _buildCodeTextField(),
              _buildStartDatePicker(),
              _buildEndDatePicker(),
              const SizedBox(height: 6),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() => Center(
        child: Text(
          widget.code != null ? 'edit_code'.tr() : 'add_code'.tr(),
          style: context.tt.titleLarge,
        ),
      );

  Widget _buildCodeTextField() => MainTextField2(
        initialText: widget.code?.code,
        onChanged: onCodeChanged,
        icon: Icons.qr_code,
        label: 'code'.tr(),
        validator: (v) => v == null || v.isEmpty ? 'required_field'.tr() : null,
      );

  Widget _buildStartDatePicker() => MainDatePicker(
        isStart: true,
        initialDate: widget.code?.startDate,
        onDateSelected: onStartDateSelected,
      );

  Widget _buildEndDatePicker() => MainDatePicker(
        isEnd: true,
        initialDate: widget.code?.endDate,
        onDateSelected: onEndDateSelected,
      );

  Widget _buildSubmitButton() => BlocConsumer<CodesCubit, GeneralCodesState>(
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
            child = LoadingIndicator(size: 30, color: context.cs.surface);
          }
          return MainActionButton(
            text: 'save'.tr(),
            onTap: onTap,
            child: child,
          );
        },
      );
}
