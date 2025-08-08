import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/about_us/view/about_us_view.dart';
import 'package:wellnesstrackerapp/features/privacy_policy/view/privacy_policy_view.dart';
import 'package:wellnesstrackerapp/features/profile/cubit/profile_cubit.dart';
import 'package:wellnesstrackerapp/features/settings/view/settings_view.dart';
import 'package:wellnesstrackerapp/features/terms_and_conditions/view/terms_and_conditions_view.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class ProfileViewCallbacks {
  Future<void> onRefresh();
  void onTryAgainTap();
  void onSettingsTap();
  void onAboutUsTap();
  void onTermsAndConditionsTap();
  void onPrivacyPolicyTap();
}

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    implements ProfileViewCallbacks {
  late final ProfileCubit profileCubit = context.read();

  @override
  void initState() {
    super.initState();
    profileCubit.getProfile();
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => profileCubit.getProfile();

  @override
  void onAboutUsTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutUsView(),
      ),
    );
  }

  @override
  void onPrivacyPolicyTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrivacyPolicyView(),
      ),
    );
  }

  @override
  void onSettingsTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsView(role: UserRoleEnum.user),
      ),
    );
  }

  @override
  void onTermsAndConditionsTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TermsAndConditionsView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'profile'.tr()),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: AppConstants.padding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              BlocBuilder<ProfileCubit, GeneralProfileState>(
                buildWhen: (previous, current) => current is ProfileState,
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return LoadingIndicator();
                  } else if (state is ProfileSuccess) {
                    final profile = state.customer;
                    final info = profile.info;
                    return Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 48,
                            backgroundColor:
                                context.cs.primary.withValues(alpha: 0.7),
                            child: Icon(
                              Icons.person,
                              color:
                                  context.cs.secondary.withValues(alpha: 0.7),
                              size: 45,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                profile.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  text: profile.level?.name,
                                  style: TextStyle(color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text:
                                          '| ${profile.totalPoints?.toString() ?? 0} نقطة',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (info != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _InfoCard(
                                label: 'weight',
                                value: info.weight.toString(),
                                unit: 'Kg',
                              ),
                              _InfoCard(
                                label: 'Height',
                                value: info.length.toString(),
                                unit: 'cm',
                              ),
                              _InfoCard(
                                label: 'Age',
                                value: info.age.toString(),
                                unit: 'Year',
                              ),
                            ],
                          ),
                      ],
                    );
                  } else if (state is ProfileFail) {
                    return MainErrorWidget(
                      error: state.error,
                      onTryAgainTap: onTryAgainTap,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 20),
              SizedBox(height: 10),
              ProfileOptionWidget(
                icon: Icons.settings,
                title: "settings".tr(),
                onTap: onSettingsTap,
              ),
              SizedBox(height: 16),
              ProfileOptionWidget(
                icon: Icons.info,
                title: "about_us".tr(),
                onTap: onAboutUsTap,
              ),
              SizedBox(height: 16),
              ProfileOptionWidget(
                icon: Icons.star,
                title: "rate_us".tr(),
                onTap: () => context.router.push(AddRateRoute()),
              ),
              SizedBox(height: 16),
              ProfileOptionWidget(
                icon: Icons.article,
                title: "terms_and_conditions".tr(),
                onTap: onTermsAndConditionsTap,
              ),
              SizedBox(height: 16),
              ProfileOptionWidget(
                icon: Icons.privacy_tip,
                title: "privacy_policy".tr(),
                onTap: onPrivacyPolicyTap,
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _InfoCard({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: context.cs.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColors.firstShadow,
      ),
      child: Column(
        children: [
          Text(
            '$value$unit',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class ProfileOptionWidget extends StatelessWidget {
  const ProfileOptionWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppConstants.padding20,
        decoration: BoxDecoration(
          color: context.cs.surface,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: AppColors.firstShadow,
        ),
        child: Row(
          children: [
            Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                color: context.cs.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 20.0, color: context.cs.primary),
            ),
            SizedBox(width: 10),
            Expanded(child: Text(title, style: context.tt.bodyMedium)),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_ios,
                color: context.cs.onTertiary, size: 16.0)
          ],
        ),
      ),
    );
  }
}
