import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/company_info/view/widgets/update_company_info_widget.dart';
import 'package:wellnesstrackerapp/features/settings/cubit/settings_cubit.dart';
import 'package:wellnesstrackerapp/features/settings/model/settings_model/settings_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class CompanyInfoViewCallBacks {
  void onTryAgainTap();
  Future<void> onRefresh();
  void onEditTap(SettingsModel settings);
}

@RoutePage()
class CompanyInfoView extends StatelessWidget {
  const CompanyInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<SettingsCubit>()..getSettings(),
      child: const CompanyInfoPage(),
    );
  }
}

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage>
    implements CompanyInfoViewCallBacks {
  SettingsSuccess? localState;
  late final SettingsCubit settingsCubit = context.read();
  @override
  void onTryAgainTap() => settingsCubit.getSettings();

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onEditTap(SettingsModel settings) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (bottomSheetContext) => UpdateCompanyInfoWidget(
        settingsCubit: settingsCubit,
        onSuccess: onTryAgainTap,
        settings: settings,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('company_info'.tr(), style: context.tt.titleLarge),
        actions: [
          if (localState != null && localState is SettingsSuccess)
            IconButton(
              onPressed: () => onEditTap(localState!.settings),
              icon: Icon(Icons.edit),
            )
        ],
      ),
      body: BlocConsumer<SettingsCubit, GeneralSettingsState>(
        listener: (context, state) {
          if (state is SettingsSuccess) {
            setState(() => localState = state);
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading) {
            return LoadingIndicator();
          } else if (state is SettingsSuccess) {
            final settings = state.settings;
            return Padding(
              padding: AppConstants.padding16,
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    _buildInfoCard(
                      icon: Icons.account_circle,
                      title: 'app_name',
                      value: settings.name,
                    ),
                    _buildInfoCard(
                      icon: Icons.android,
                      title: 'android_url',
                      value: settings.appUrlAndroid ?? 'not_provided'.tr(),
                    ),
                    _buildInfoCard(
                      icon: Icons.apple,
                      title: 'ios_url',
                      value: settings.appUrlIos ?? 'not_provided'.tr(),
                    ),
                    _buildInfoCard(
                      icon: Icons.email,
                      title: 'support_email',
                      value: settings.email,
                    ),
                    _buildInfoCard(
                      icon: Icons.phone,
                      title: 'support_phone',
                      value: settings.supportPhoneNumber,
                    ),
                    _buildInfoCard(
                      icon: Icons.phone,
                      title: 'phycological_support_phone',
                      value: settings.psychologicalPhoneNumber ??
                          'not_provided'.tr(),
                    ),
                    SizedBox(height: 300),
                  ],
                ),
              ),
            );
          } else if (state is SettingsFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: AppConstants.paddingV8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, size: 28, color: context.cs.primary),
        title: Text(
          title.tr(),
          style: context.tt.titleMedium,
        ),
        subtitle: Text(value, style: context.tt.bodySmall),
      ),
    );
  }
}
