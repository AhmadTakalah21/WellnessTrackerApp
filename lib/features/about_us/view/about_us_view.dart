import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/model/sign_in_model/sign_in_model.dart';
import 'package:wellnesstrackerapp/global/services/user_repo.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/animations/tile_slide_animation.dart';

abstract class AboutUsViewCallBacks {}

@RoutePage()
class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AboutUsPage();
  }
}

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    implements AboutUsViewCallBacks {
  late final SignInModel? user = context.read<SignInModel?>();
  late final UserRepo userRepo = context.read();

  late final List<List<String>> items = [
    ['personal_nutrition_title'.tr(), 'personal_nutrition_subtitle'.tr()],
    ['daily_exercises_title'.tr(), 'daily_exercises_subtitle'.tr()],
    ['direct_followup_title'.tr(), 'direct_followup_subtitle'.tr()],
    ['consultations_title'.tr(), 'consultations_subtitle'.tr()],
    if (userRepo.isV1) ...[
      ['rewards_title'.tr(), 'rewards_subtitle'.tr()],
      ['levels_title'.tr(), 'levels_subtitle'.tr()],
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('about_us'.tr())),
      body: SingleChildScrollView(
        padding: AppConstants.padding16,
        child: Column(
          children: [
            const SizedBox(height: 16),
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return TileSlideAnimation(
                index: index,
                child: _WorkoutItem(title: item[0], subtitle: item[1]),
              );
            }),
            const SizedBox(height: 115),
          ],
        ),
      ),
    );
  }
}

class _WorkoutItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _WorkoutItem({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppConstants.paddingV8,
      padding: AppConstants.padding16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.tt.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: context.tt.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.cs.surface,
              border: Border.all(width: 0.5),
              shape: BoxShape.circle,
            ),
            child: Image.asset(AppConstants.apkLogo, width: 60, height: 60),
          ),
        ],
      ),
    );
  }
}
