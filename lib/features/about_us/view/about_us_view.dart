import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class AboutUsViewCallBacks{}

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

class _AboutUsPageState extends State<AboutUsPage> implements AboutUsViewCallBacks{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('about_us'.tr(), style: context.tt.titleLarge),
      ),
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          children: [
            Text("خدماتنا", style: context.tt.headlineLarge),
              const SizedBox(height: 16),
              _WorkoutItem(
                title: 'Lose your weight',
                subtitle: '10 workouts / Level 1 Newbie',
              ),
              const SizedBox(height: 12),
              _WorkoutItem(
                title: 'Quick full body stretches',
                subtitle: '10 workouts / Level 1 Newbie',
              ),
              const SizedBox(height: 12),
              _WorkoutItem(
                title: 'Morning Yoga',
                subtitle: '10 workouts / Level 1 Newbie',
              ),
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
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.cs.primary.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              "assets/images/app_logo.png",
              width: 70,
              height: 70,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}