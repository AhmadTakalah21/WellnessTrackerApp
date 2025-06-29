import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

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

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: AppConstants.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),

            Center(
              child: CircleAvatar(
                radius: 48,
                foregroundColor: context.cs.onSecondaryFixed,
                backgroundColor: context.cs.onSecondaryFixed,
                child:
                    Icon(Icons.person, color: context.cs.onTertiary, size: 45),
              ),
            ),
            const SizedBox(height: 12),

            // Name
            Center(
              child: Column(
                children: [
                  const Text(
                    'اسم المستخدم',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: const TextSpan(
                      text: 'المستوى 1 ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: '| 500 نقطة',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _InfoCard(label: 'weight', value: '65', unit: 'Kg'),
                _InfoCard(label: 'Height', value: '127', unit: 'cm'),
                _InfoCard(label: 'Age', value: '19', unit: 'Year'),
              ],
            ),
            const SizedBox(height: 30),
            Text("خدماتنا", style: context.tt.headlineLarge),
            const SizedBox(height: 16),
            // Activities List
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
            const SizedBox(height: 20),
          ],
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
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.3),
            offset: Offset(0, 4),
            blurRadius: 4
          )
        ]
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
