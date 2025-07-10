import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/settings/cubit/settings_cubit.dart';
import 'package:wellnesstrackerapp/features/settings/model/settings_model/settings_model.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final model = widget.settings;
    widget.settingsCubit.setName(model.name);
    widget.settingsCubit.setEmail(model.email);
    widget.settingsCubit.setSupportPhoneNumber(model.supportPhoneNumber);
    widget.settingsCubit.setAppUrlAndroid(model.appUrlAndroid);
    widget.settingsCubit.setAppUrlIos(model.appUrlIos);
  }

  void onSave() => widget.settingsCubit.updateSettings();
  void onCancelTap() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: AppConstants.padding20,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'update_info'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 16),
              MainTextField2(
                initialText: widget.settings.name,
                onChanged: widget.settingsCubit.setName,
                icon: Icons.title,
                label: 'name'.tr(),
                validator: (val) =>
                    val == null || val.isEmpty ? 'name_required'.tr() : null,
              ),
              const SizedBox(height: 12),
              MainTextField2(
                initialText: widget.settings.email,
                onChanged: widget.settingsCubit.setEmail,
                icon: Icons.email,
                label: 'email'.tr(),
                validator: (val) =>
                    val == null || val.isEmpty ? 'email_required'.tr() : null,
              ),
              const SizedBox(height: 12),
              MainTextField2(
                initialText: widget.settings.supportPhoneNumber,
                onChanged: widget.settingsCubit.setSupportPhoneNumber,
                icon: Icons.phone,
                label: 'support_phone'.tr(),
                validator: (val) => val == null || val.isEmpty
                    ? 'support_phone_required'.tr()
                    : null,
              ),
              const SizedBox(height: 12),
              MainTextField2(
                initialText: widget.settings.appUrlAndroid,
                onChanged: widget.settingsCubit.setAppUrlAndroid,
                icon: Icons.android,
                label: 'android_url'.tr(),
              ),
              const SizedBox(height: 12),
              MainTextField2(
                initialText: widget.settings.appUrlIos,
                onChanged: widget.settingsCubit.setAppUrlIos,
                icon: Icons.apple,
                label: 'ios_url'.tr(),
              ),
              const SizedBox(height: 30),
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
                    child = const LoadingIndicator(size: 30);
                  }
                  return MainActionButton(
                    text: 'update'.tr(),
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
