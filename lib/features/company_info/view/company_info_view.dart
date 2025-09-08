// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:wellnesstrackerapp/features/company_info/view/widgets/update_company_info_widget.dart';
import 'package:wellnesstrackerapp/features/settings/cubit/settings_cubit.dart';
import 'package:wellnesstrackerapp/features/settings/model/settings_model/settings_model.dart';
import 'package:wellnesstrackerapp/global/blocs/share_cubit/cubit/share_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/animations/tile_slide_animation.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

class IconTitleValueFunc {
  final IconData icon;
  final String title;
  final String value;
  final void Function()? onTap;

  IconTitleValueFunc(this.icon, this.title, this.value, this.onTap);
}

abstract class CompanyInfoViewCallBacks {
  void onTryAgainTap();
  Future<void> onRefresh();
  void onEditTap(SettingsModel settings);
  void onShareTap(String? url, String title);
  Future<void> onLaunchEmailTap(String? email);
  Future<void> onLaunchPhoneTap(String? whatsappPhone);
}

@RoutePage()
class CompanyInfoView extends StatelessWidget {
  const CompanyInfoView({super.key, required this.role});
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => get<SettingsCubit>()..getSettings()),
        BlocProvider(create: (context) => get<ShareCubit>()),
      ],
      child: CompanyInfoPage(role: role),
    );
  }
}

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key, required this.role});
  final UserRoleEnum role;

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage>
    implements CompanyInfoViewCallBacks {
  late final SettingsCubit settingsCubit = context.read();
  late final ShareCubit shareCubit = context.read();

  SettingsSuccess? localState;
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
  Future<void> onShareTap(String? url, String title) async {
    if (url == null || url.isEmpty) return;
    await shareCubit.share(url, title);
  }

  @override
  Future<void> onLaunchEmailTap(String? email) async {
    if (email == null || email.isEmpty) return;

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeFull('subject=Support Request&body=Hello,'),
    );

    final success = await launchUrlString(emailUri.toString());
    if (!success && mounted) {
      MainSnackBar.showErrorMessage(context, "cant_open_email".tr());
    }
  }

  @override
  Future<void> onLaunchPhoneTap(String? whatsappPhone) async {
    if (whatsappPhone == null || whatsappPhone.isEmpty) return;

    final cleaned = whatsappPhone.replaceAll(RegExp(r'[^\d]'), '');
    final message = Uri.encodeComponent("مرحباً، أحتاج كود الاشتراك");
    final url = "https://wa.me/$cleaned?text=$message";

    final success =
        await launchUrlString(url, mode: LaunchMode.externalApplication);
    if (!success && context.mounted) {
      if (mounted) {
        MainSnackBar.showErrorMessage(context, "cant_open_whatsapp".tr());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('company_info'.tr()),
        actions: [
          if (widget.role.isAdmin &&
              localState != null &&
              localState is SettingsSuccess)
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
            final List<IconTitleValueFunc> items = [
              IconTitleValueFunc(
                Icons.account_circle,
                'app_name',
                settings.name,
                null,
              ),
              IconTitleValueFunc(
                Icons.android,
                'android_url',
                settings.appUrlAndroid ?? 'not_provided'.tr(),
                () => onShareTap(settings.appUrlAndroid, "android_url".tr()),
              ),
              IconTitleValueFunc(
                Icons.apple,
                'ios_url',
                settings.appUrlIos ?? 'not_provided'.tr(),
                () => onShareTap(settings.appUrlIos, "ios_url".tr()),
              ),
              IconTitleValueFunc(
                Icons.email,
                'support_email',
                settings.email,
                () => onLaunchEmailTap(settings.email),
              ),
              IconTitleValueFunc(
                Icons.phone,
                'support_phone',
                settings.supportPhoneNumber,
                () => onLaunchPhoneTap(settings.supportPhoneNumber),
              ),
              IconTitleValueFunc(
                Icons.phone,
                'emergencies_phone',
                settings.emergenciesPhone ?? 'not_provided'.tr(),
                () => onLaunchPhoneTap(settings.emergenciesPhone),
              ),
            ];
            return Padding(
              padding: AppConstants.padding16,
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    ...items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return TileSlideAnimation(
                        index: index,
                        child: _buildInfoCard(
                          icon: item.icon,
                          title: item.title,
                          value: item.value,
                          onTap: item.onTap,
                        ),
                      );
                    }),
                    SizedBox(height: 150),
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
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
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
      ),
    );
  }
}
