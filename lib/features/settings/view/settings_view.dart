import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/app_manager/cubit/app_manager_cubit.dart';
import 'package:wellnesstrackerapp/global/localization/supported_locales.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class SettingsViewCallBacks {
  void onChangeLanguageTap();
  void onInfoTap();
}

@RoutePage()
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsPage();
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    implements SettingsViewCallBacks {
  late final AppManagerCubit appManagerCubit = context.read();
  late bool isArabic = context.locale == SupportedLocales.arabic;

  @override
  void onInfoTap() {
    context.router.push(CompanyInfoRoute());
  }

  @override
  void onChangeLanguageTap() {
    setState(() {
      isArabic = !isArabic;
    });
    if (isArabic) {
      context.setLocale(SupportedLocales.arabic);
    } else {
      context.setLocale(SupportedLocales.english);
    }
    appManagerCubit.emitLanuageChangedState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('settings'.tr(), style: context.tt.titleLarge),
      ),
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          spacing: 20,
          children: [
            settingsWithSwitch(
              "current_language".tr(),
              isArabic,
              onChangeLanguageTap,
            ),
            settingsTile("company_info".tr(), onInfoTap)
          ],
        ),
      ),
    );
  }

  Widget settingsWithSwitch(String title, bool value, Function() onTap) {
    return Container(
      padding: AppConstants.padding8,
      decoration: BoxDecoration(
        color: context.cs.surface,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: AppColors.firstShadow,
      ),
      child: SwitchListTile(
        value: value,
        onChanged: (value) => onTap(),
        title: Text(title, style: context.tt.titleMedium),
        activeColor: context.cs.primary,
        inactiveThumbColor: context.cs.secondary,
        activeTrackColor: context.cs.primary.withValues(alpha: 0.4),
        inactiveTrackColor: context.cs.secondary.withValues(alpha: 0.2),
        dense: true,
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  Widget settingsTile(String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: AppConstants.padding8,
          decoration: BoxDecoration(
            color: context.cs.surface,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: AppColors.firstShadow,
          ),
          child: ListTile(
            leading: Text(title, style: context.tt.titleMedium),
            dense: true,
            visualDensity: VisualDensity.compact,
            trailing: Container(
              decoration: BoxDecoration(
                color: context.cs.primary.withAlpha((0.2 * 255).toInt()),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.info, color: context.cs.primary),
              ),
            ),
          )),
    );
  }
}
