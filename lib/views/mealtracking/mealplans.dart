import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



class MealPlansScreen extends StatelessWidget {
  const MealPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Plans", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.more_vert, color: Colors.black), onPressed: () {})],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Weight Loss Goal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GoalTile(title: "49.0", subtitle: "Goal weight"),
                        GoalTile(title: "-0.27", subtitle: "Goal Rate"),
                        GoalTile(title: "-0.5%", subtitle: "Goal Rate"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Text("Your Progress", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Coached Program", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        DropdownButton(
                          value: "Weekly",
                          items: ["Daily", "Weekly"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    NutritionBarChart(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 7),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.8,
                crossAxisSpacing: 5,
                mainAxisSpacing: 3,
                children: [
                  MetricTile(icon: Icons.favorite, color: Colors.red, value: "96 Bpm", label: "Heart Rate"),
                  MetricTile(icon: Icons.local_drink, color: Colors.blue, value: "1200 ml", label: "Water"),
                  MetricTile(icon: Icons.directions_walk, color: Colors.orange, value: "4352 ", label: "Steps"),
                  MetricTile(icon: Icons.bedtime, color: Colors.purple, value: "7h 36m", label: "Sleep"), MetricTile(icon: Icons.favorite, color: Colors.red, value: "96 Bpm", label: "Heart Rate"),
                  MetricTile(icon: Icons.local_drink, color: Colors.blue, value: "1200 ml", label: "Water"),
                  MetricTile(icon: Icons.directions_walk, color: Colors.orange, value: "4352 ", label: "Steps"),
                  MetricTile(icon: Icons.bedtime, color: Colors.purple, value: "7h 36m", label: "Sleep"), MetricTile(icon: Icons.favorite, color: Colors.red, value: "96 Bpm", label: "Heart Rate"),
                  MetricTile(icon: Icons.local_drink, color: Colors.blue, value: "1200 ml", label: "Water"),
                  MetricTile(icon: Icons.directions_walk, color: Colors.orange, value: "4352 ", label: "Steps"),
                  MetricTile(icon: Icons.bedtime, color: Colors.purple, value: "7h 36m", label: "Sleep"), MetricTile(icon: Icons.favorite, color: Colors.red, value: "96 Bpm", label: "Heart Rate"),
                  MetricTile(icon: Icons.local_drink, color: Colors.blue, value: "1200 ml", label: "Water"),
                  MetricTile(icon: Icons.directions_walk, color: Colors.orange, value: "4352 ", label: "Steps"),
                  MetricTile(icon: Icons.bedtime, color: Colors.purple, value: "7h 36m", label: "Sleep"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const GoalTile({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
        Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }
}

class MetricTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const MetricTile({super.key, required this.icon, required this.color, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
                backgroundColor: color.withAlpha((0.2 * 255).toInt()),

                child: Icon(icon, color: color)),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionBarChart extends StatelessWidget {
  const NutritionBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: BarChart(
        BarChartData(
          barGroups: List.generate(7, (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(toY: 4.0, color: Colors.red, width: 8),
              BarChartRodData(toY: 3.0, color: Colors.blue, width: 8),
              BarChartRodData(toY: 2.0, color: Colors.green, width: 8),
            ],
          )),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(days[value.toInt()], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
