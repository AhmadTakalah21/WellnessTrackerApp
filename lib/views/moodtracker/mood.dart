import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

import 'moodmonitering.dart';



class MoodTrackerScreen extends StatelessWidget {
  const MoodTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Mood Tracker",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToggleButtonsWidget(),
            SizedBox(height: 10),
            MoodChartWidget(),
            SizedBox(height: 10),
            SummaryWidget(),
            SizedBox(height: 10),
            ExerciseWidget(),
            SizedBox(height: 10),
            MoodSuggestionsWidget(),
          ],
        ),
      ),
    );
  }
}

class ToggleButtonsWidget extends StatelessWidget {
  const ToggleButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ToggleButton(text: "Day"),
        ToggleButton(text: "Week", isSelected: true),
        ToggleButton(text: "Month"),
        ToggleButton(text: "Year"),
      ],
    );
  }
}

class ToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;

  const ToggleButton({super.key, required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.deepPurpleAccent : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MoodChartWidget extends StatelessWidget {
  const MoodChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
      ),
      padding: EdgeInsets.all(16),
      child: SizedBox(
        height: 250,
        child: BarChart(
          BarChartData(
            barGroups: [
              makeGroupData(0, 30, Colors.orange),
              makeGroupData(1, 50, Colors.green),
              makeGroupData(2, 70, Colors.blue),
              makeGroupData(3, 80, Colors.red),
              makeGroupData(4, 60, Colors.blue),
              makeGroupData(5, 30, Colors.orange),
              makeGroupData(6, 50, Colors.green),
            ],
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(show: true),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [BarChartRodData(toY: y, color: color, width: 15)],
    );
  }
}

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text("🏆 Summary", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text("Your weekly mood insights and analytics."),
        trailing: TextButton(
          onPressed: () {},
          child: Text("View all", style: TextStyle(color: Colors.deepPurpleAccent)),
        ),
      ),
    );
  }
}

class ExerciseWidget extends StatelessWidget {
  const ExerciseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(FontAwesomeIcons.spa, color: Colors.orange, size: 40),
        title: Text("Mindful Breathing"),
        subtitle: Text("A guided exercise for relaxation."),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>MoodMonitoringScreen()));

          },
          child: Text("Start",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}

class MoodSuggestionsWidget extends StatelessWidget {
  const MoodSuggestionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("✨ Mood Improvement Tips", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("• Take deep breaths and relax your mind."),
          Text("• Go for a walk or engage in physical activity."),
          Text("• Listen to calming music or meditate."),
          Text("• Connect with friends or loved ones."),
        ],
      ),
    );
  }
}