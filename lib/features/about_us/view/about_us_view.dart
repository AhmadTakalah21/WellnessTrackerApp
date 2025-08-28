import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
  final List<List<String>> items = [
    ['Lose your weight', '10 workouts / Level 1 Newbie'],
    ['Quick full body stretches', '10 workouts / Level 1 Newbie'],
    ['Morning Yoga', '10 workouts / Level 1 Newbie'],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('about_us'.tr())),
      body: Padding(
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
      margin: AppConstants.paddingV4,
      padding: AppConstants.padding16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.cs.surface,
              border: Border.all(width: 0.5),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              "assets/images/app_logo.png",
              width: 80,
              height: 80,
            ),
          ),
        ],
      ),
    );
  }
}
