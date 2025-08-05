import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/settings/cubit/settings_cubit.dart';
import 'package:wellnesstrackerapp/features/settings/model/settings_model/settings_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class UpdateCompanyInfoWidget extends StatefulWidget {
  const UpdateCompanyInfoWidget({
    super.key,
    required this.settings,
    this.onSuccess,
    required this.settingsCubit,
  });

  final SettingsModel settings;
  final SettingsCubit settingsCubit;
  final VoidCallback? onSuccess;

  @override
  State<UpdateCompanyInfoWidget> createState() =>
      _UpdateCompanyInfoWidgetState();
}

class _UpdateCompanyInfoWidgetState extends State<UpdateCompanyInfoWidget> {
  @override
  void initState() {
    super.initState();
    final model = widget.settings;
    widget.settingsCubit.setModel(model);
  }

  void onSave() => widget.settingsCubit.updateSettings();
  void onCancelTap() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: AppConstants.padding20,
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(),
            const SizedBox(height: 4),
            _buildNameTextField(),
            _buildEmailTextField(),
            _buildPhoneTextField(),
            _buildPsycologicalPhoneTextField(),
            _buildAndroidUrlTextField(),
            _buildIosUrlTextField(),
            const SizedBox(height: 6),
            _buildSubmitButton(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() =>
      Center(child: Text('update_info'.tr(), style: context.tt.titleLarge));

  Widget _buildNameTextField() => MainTextField2(
        initialText: widget.settings.name,
        onChanged: widget.settingsCubit.setName,
        icon: Icons.title,
        label: 'name'.tr(),
        validator: (v) => v == null || v.isEmpty ? 'name_required'.tr() : null,
      );

  Widget _buildEmailTextField() => MainTextField2(
        initialText: widget.settings.email,
        onChanged: widget.settingsCubit.setEmail,
        icon: Icons.email,
        label: 'email'.tr(),
        validator: (v) => v == null || v.isEmpty ? 'email_required'.tr() : null,
      );

  Widget _buildPhoneTextField() => MainTextField2(
        initialText: widget.settings.supportPhoneNumber,
        onChanged: widget.settingsCubit.setSupportPhoneNumber,
        icon: Icons.phone,
        label: 'support_phone'.tr(),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
        ],
        hint: '+963987654321',
        validator: (v) {
          if (v == null || v.isEmpty) return 'support_phone_required'.tr();
          final cleaned =
              v.replaceAll(RegExp(r'[^\d+]'), '').replaceAll('+', '');
          if (cleaned.length < 8) return 'رقم الهاتف غير صحيح';
          return null;
        },
      );

  Widget _buildPsycologicalPhoneTextField() => MainTextField2(
        initialText: widget.settings.psychologicalPhoneNumber,
        onChanged: widget.settingsCubit.setPsychologicalPhoneNumber,
        icon: Icons.phone,
        label: 'phycological_support_phone'.tr(),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
        ],
        hint: '+963987654321',
        validator: (v) {
          if (v == null || v.isEmpty) {
            return 'psychological_phone_required'.tr();
          }
          final cleaned =
              v.replaceAll(RegExp(r'[^\d+]'), '').replaceAll('+', '');
          if (cleaned.length < 8) return 'رقم الهاتف غير صحيح';
          return null;
        },
      );

  Widget _buildAndroidUrlTextField() => MainTextField2(
        initialText: widget.settings.appUrlAndroid,
        onChanged: widget.settingsCubit.setAppUrlAndroid,
        icon: Icons.android,
        label: 'android_url'.tr(),
      );

  Widget _buildIosUrlTextField() => MainTextField2(
        initialText: widget.settings.appUrlIos,
        onChanged: widget.settingsCubit.setAppUrlIos,
        icon: Icons.apple,
        label: 'ios_url'.tr(),
      );

  Widget _buildSubmitButton() =>
      BlocConsumer<SettingsCubit, GeneralSettingsState>(
        bloc: widget.settingsCubit,
        listener: (context, state) {
          if (state is UpdateSettingsSuccess) {
            widget.onSuccess?.call();
            onCancelTap();
            MainSnackBar.showSuccessMessage(context, state.message);
          } else if (state is UpdateSettingsFail) {
            MainSnackBar.showErrorMessage(context, state.error);
          }
        },
        builder: (context, state) {
          Widget? child;
          var onTap = onSave;
          if (state is UpdateSettingsLoading) {
            onTap = () {};
            child = LoadingIndicator(size: 30, color: context.cs.surface);
          }
          return MainActionButton(
            text: 'update'.tr(),
            onTap: onTap,
            child: child,
          );
        },
      );
}
