import 'dart:io';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/profile/cubit/profile_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/animations/tile_slide_animation.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

// TODO check
class IconTitleFuncModel {
  final IconData icon;
  final String title;
  final Color? color;
  final void Function() onTap;

  IconTitleFuncModel(this.icon, this.title, this.onTap, {this.color});
}

abstract class ProfileViewCallbacks {
  Future<void> onRefresh();
  void onTryAgainTap();
  void onSettingsTap();
  void onAboutUsTap();
  void onRateUsTap();
  void onTermsAndConditionsTap();
  void onPrivacyPolicyTap();
  void onDeleteAccountTap();
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
  // late final SignInModel user = context.read<SignInModel>();
  late final SignInModel? user = context.read<SignInModel?>();
  late final ProfileCubit profileCubit = context.read();
  late final UserRepo userRepo = context.read();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    profileCubit.getProfile();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
      profileCubit.setImage(pickedImage);
    }
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() {
    _pickedImage = null;
    profileCubit.getProfile();
  }

  @override
  void onAboutUsTap() => context.router.push(AboutUsRoute());

  @override
  void onRateUsTap() => context.router.push(AddRateRoute());

  @override
  void onPrivacyPolicyTap() => context.router.push(PrivacyPolicyRoute());

  @override
  void onSettingsTap() =>
      context.router.push(SettingsRoute(role: UserRoleEnum.user));

  @override
  void onTermsAndConditionsTap() =>
      context.router.push(TermsAndConditionsRoute());

  @override
  void onDeleteAccountTap() {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => get<AuthCubit>(),
          child: AlertDialog(
            title: Text('delete_account'.tr()),
            content: Text('delete_account_confirmation'.tr()),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: MainActionButton(
                      onTap: () => Navigator.of(context).pop(),
                      text: "cancel".tr(),
                      textColor: context.cs.surface,
                      buttonColor: context.cs.primary,
                      shadow: AppColors.secondShadow,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LogOutSuccess) {
                          Navigator.of(context).pop();
                        } else if (state is SignInFail) {
                          MainSnackBar.showErrorMessage(context, state.error);
                        }
                      },
                      builder: (context, state) {
                        return MainActionButton(
                          onTap: () => context.read<AuthCubit>().logout(),
                          buttonColor: context.cs.error,
                          text: "delete".tr(),
                          isLoading: state is SignInLoading,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<IconTitleFuncModel> tiles = [
      IconTitleFuncModel(Icons.settings, "settings".tr(), onSettingsTap),
      IconTitleFuncModel(Icons.info, "about_us".tr(), onAboutUsTap),
      IconTitleFuncModel(Icons.star, "rate_us".tr(), onRateUsTap),
      IconTitleFuncModel(
          Icons.article, "terms_and_conditions".tr(), onTermsAndConditionsTap),
      IconTitleFuncModel(
          Icons.privacy_tip, "privacy_policy".tr(), onPrivacyPolicyTap),
      // if (!user.isV1)
      if (!userRepo.isV1)
        IconTitleFuncModel(
          Icons.delete,
          "delete_account".tr(),
          onDeleteAccountTap,
          color: context.cs.error,
        ),
    ];
    return Scaffold(
      appBar: MainAppBar(title: 'profile'.tr(), role: UserRoleEnum.user),
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
                  Widget child;
                  if (state is ProfileLoading) {
                    child = LoadingIndicator();
                  } else if (state is ProfileSuccess) {
                    final profile = state.customer;
                    final info = profile.info;
                    child = Column(
                      children: [
                        _buildImagePicker(profile),
                        const SizedBox(height: 12),
                        // _buildNameWithLevelAndPoints(profile, user.isV1),
                        _buildNameWithLevelAndPoints(profile, userRepo.isV1),
                        const SizedBox(height: 16),
                        if (info != null) _buildCards(profile),
                        SizedBox(height: 10)
                      ],
                    );
                  } else if (state is ProfileFail) {
                    child = MainErrorWidget(
                      error: state.error,
                      onTryAgainTap: onTryAgainTap,
                    );
                  } else {
                    child = SizedBox.shrink();
                  }
                  return AnimatedSizeAndFade(child: child);
                },
              ),
              const SizedBox(height: 10),
              ...tiles.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                return TileSlideAnimation(
                  index: index,
                  child: ProfileOptionWidget(option: option),
                );
              }),
              const SizedBox(height: 115),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(CustomerModel profile) {
    final initialImage = CircleAvatar(
      radius: 48,
      backgroundColor: context.cs.primary.withValues(alpha: 0.7),
      child: Icon(
        Icons.person,
        color: context.cs.secondary.withValues(alpha: 0.7),
        size: 45,
      ),
    );
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: _pickedImage != null
            ? ClipRRect(
                borderRadius: AppConstants.borderRadiusCircle,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.cs.primary.withValues(alpha: 0.7),
                  ),
                  child: Image.file(
                    _pickedImage!,
                    width: 95,
                    height: 95,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : profile.image != null
                ? AppImageWidget(
                    url: profile.image!,
                    width: 95,
                    height: 95,
                    borderRadius: AppConstants.borderRadiusCircle,
                    backgroundColor: context.cs.primary.withValues(alpha: 0.7),
                    errorWidget: Icon(
                      Icons.person,
                      color: context.cs.secondary.withValues(alpha: 0.7),
                      size: 45,
                    ),
                  )
                : initialImage,
      ),
    );
  }

  Widget _buildNameWithLevelAndPoints(CustomerModel profile, bool isV1) {
    return Center(
      child: Column(
        children: [
          Text(
            profile.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          if (isV1)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (profile.level != null)
                  Text(profile.level!.name,
                      style: TextStyle(color: Colors.grey)),
                SizedBox(width: 4),
                Text(
                  "| ${profile.totalPoints?.toString() ?? 0} ${"point".tr()}",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                )
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCards(CustomerModel profile) {
    final info = profile.info;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _InfoCard(
          label: 'weight'.tr(),
          value: info!.weight.toString(),
          unit: 'Kg',
        ),
        _InfoCard(
          label: 'height'.tr(),
          value: info.length.toString(),
          unit: 'cm',
        ),
        _InfoCard(
          label: 'age'.tr(),
          value: profile.age?.toString() ?? "not_provided".tr(),
          unit: 'year'.tr(),
        ),
      ],
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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: context.cs.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppColors.firstShadow,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  '$value $unit',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
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
  const ProfileOptionWidget({super.key, required this.option});

  final IconTitleFuncModel option;

  @override
  Widget build(BuildContext context) {
    final color = option.color ?? context.cs.primary;
    return GestureDetector(
      onTap: option.onTap,
      child: Container(
        margin: AppConstants.paddingV8,
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
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: Icon(option.icon, size: 20.0, color: color),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                option.title,
                style: context.tt.bodyMedium?.copyWith(color: option.color),
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_ios,
                color: context.cs.onTertiary, size: 16.0)
          ],
        ),
      ),
    );
  }
}
