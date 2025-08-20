import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/codes/cubit/codes_cubit.dart';
import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_counter_widget.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.codesCubit.setModel(widget.code);
  }

  void onCancelTap() => Navigator.pop(context);
  void onSave() {
    if (_formKey.currentState!.validate()) {
      widget.codesCubit.addCode(id: widget.code?.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: AppConstants.padding20,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              _buildTitle(),
              const SizedBox(height: 4),
              _buildCodeTextField(),
              _buildValidityDaysConter(),
              const SizedBox(height: 6),
              _buildSubmitButton(),
              SizedBox(height: 20),
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
        onChanged: widget.codesCubit.setCode,
        icon: Icons.qr_code,
        label: 'code'.tr(),
        validator: (v) => v == null || v.isEmpty ? 'required_field'.tr() : null,
      );

  Widget _buildValidityDaysConter() => MainCounterWidget(
        initialCount: widget.code?.validityDays,
        label: "validity_days".tr(),
        icon: Icons.timer,
        onChanged: widget.codesCubit.setValidityDays,
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
