import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';



class ExerciseTrackerScreennnn extends StatelessWidget {
  const ExerciseTrackerScreennnn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise Tracker", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 12.0,
              animation: true,
              percent: 0.83,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("8365", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  Text("10,000 Steps", style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.green,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoCard(FontAwesomeIcons.fire, "213 Kcal", Colors.red),
                _buildInfoCard(FontAwesomeIcons.route, "4.8 Km", Colors.blue),
                _buildInfoCard(FontAwesomeIcons.clock, "1h 45m", Colors.green),
              ],
            ),
            SizedBox(height: 20),
            Expanded(child: _buildGraph()),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomIcon(FontAwesomeIcons.map, "Map", Colors.yellow),
                _buildBottomIcon(FontAwesomeIcons.heart, "Heart", Colors.red),
                _buildBottomIcon(FontAwesomeIcons.moon, "Sleep", Colors.green),
                _buildBottomIcon(FontAwesomeIcons.droplet, "Water", Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String text, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        SizedBox(height: 5),
        Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBottomIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withAlpha((0.2 * 255).toInt()),
          child: Icon(icon, color: color),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildGraph() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: [
          _buildBarGroup(1, 6),
          _buildBarGroup(2, 8),
          _buildBarGroup(3, 5),
          _buildBarGroup(4, 7),
          _buildBarGroup(5, 6),
          _buildBarGroup(6, 9),
        ],
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        fromY: 0,
        toY: 5000, // REQUIRED
        color: Colors.deepPurple,
      )
    ]);
  }
}
