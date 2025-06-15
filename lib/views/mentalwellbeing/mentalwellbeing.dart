import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class MentalWellbeingScreen extends StatelessWidget {
  final List<WellbeingActivity> activities = [
    WellbeingActivity("Meditation", 0.72, Colors.teal, FontAwesomeIcons.om),
    WellbeingActivity("Therapy Sessions", 0.85, Colors.indigo, FontAwesomeIcons.handHoldingHeart),
    WellbeingActivity("Sleep Quality", 0.67, Colors.purple, FontAwesomeIcons.bed),
    WellbeingActivity("Stress Levels", 0.45, Colors.red, FontAwesomeIcons.brain),
    WellbeingActivity("Daily Reflection", 0.55, Colors.blue, FontAwesomeIcons.book),
    WellbeingActivity("Breathing Exercises", 0.60, Colors.green, FontAwesomeIcons.wind),
    WellbeingActivity("Journaling", 0.80, Colors.orange, FontAwesomeIcons.pen),
    WellbeingActivity("Yoga", 0.74, Colors.pink, FontAwesomeIcons.personPraying),
    WellbeingActivity("Positive Affirmations", 0.50, Colors.cyan, FontAwesomeIcons.comment),
    WellbeingActivity("Gratitude Practice", 0.68, Colors.yellow, FontAwesomeIcons.handsPraying),
    WellbeingActivity("Mindful Eating", 0.40, Colors.brown, FontAwesomeIcons.utensils),
  ];

   MentalWellbeingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mental Wellbeing"),

        centerTitle: true,

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Mindfulness & Therapy"),
            Expanded(
              child: ListView.builder(
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return WellbeingCard(activity: activities[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
      ),
    );
  }
}

class WellbeingCard extends StatelessWidget {
  final WellbeingActivity activity;
  const WellbeingCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: activity.color.withAlpha((0.2 * 255).toInt()),
              child: Icon(activity.icon, color: activity.color, size: 22),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activity.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey[900])),
                  SizedBox(height: 6),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: activity.progress),
                    duration: Duration(seconds: 1),
                    builder: (context, value, child) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: value,
                          color: activity.color,
                          backgroundColor: activity.color.withAlpha((0.2 * 255).toInt()),
                          minHeight: 8,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 4),
                  Text("${(activity.progress * 100).toInt()}% Completed",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.blueGrey[700])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WellbeingActivity {
  final String title;
  final double progress;
  final Color color;
  final IconData icon;
  WellbeingActivity(this.title, this.progress, this.color, this.icon);
}
