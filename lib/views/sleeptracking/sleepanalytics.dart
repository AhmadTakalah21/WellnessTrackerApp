import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MaterialApp(
    home: SleepAnalyticsScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class SleepAnalyticsScreen extends StatelessWidget {
  const SleepAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text("Sleep Analytics", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("Based on our data", style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            SleepSummaryCard(),
            const SizedBox(height: 20),
            Text("Sleep Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: MonthlyChangeCard("+26%", Colors.green, Icons.trending_up)),
                const SizedBox(width: 10),
                Expanded(child: MonthlyChangeCard("-30%", Colors.red, Icons.trending_down)),
              ],
            ),
            const SizedBox(height: 20),
            SleepMetricsSection(),
            const SizedBox(height: 20),
            Text("Weekly Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SleepChart(),
          ],
        ),
      ),
    );
  }
}

class SleepSummaryCard extends StatelessWidget {
  const SleepSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple, Colors.deepPurpleAccent]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "You almost reached a perfect month of sleep",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          CircularPercentIndicator(75),
          Icon(Icons.close, color: Colors.white)
        ],
      ),
    );
  }
}

class CircularPercentIndicator extends StatelessWidget {
  final int percentage;

  const CircularPercentIndicator(this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.white30,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 6,
          ),
          Center(
            child: Text(
              "$percentage%",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class MonthlyChangeCard extends StatelessWidget {
  final String percentage;
  final Color color;
  final IconData icon;

  const MonthlyChangeCard(this.percentage, this.color, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Monthly Change", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 5),
              Text(percentage, style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

class SleepMetricsSection extends StatelessWidget {
  const SleepMetricsSection({super.key});


  @override
  Widget build(BuildContext context) {
  return Column(
  children: [
  SleepMetricCard("Deep Sleep", "4h 30m", Colors.blue, Icons.nightlight_round),
  const SizedBox(height: 10),
  SleepMetricCard("REM Sleep", "2h 15m", Colors.orange, Icons.remove_red_eye),
  const SizedBox(height: 10),
  SleepMetricCard("Light Sleep", "3h 45m", Colors.green, Icons.wb_sunny),
  ],
  );
  }
}





class SleepMetricCard extends StatelessWidget {
  final String title;
  final String duration;
  final Color color;
  final IconData icon;

  const SleepMetricCard(this.title, this.duration, this.color, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Text(duration, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

class SleepChart extends StatelessWidget {
  const SleepChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(16),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                  return Text(days[value.toInt()], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
                },
                interval: 1,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 6.5),
                FlSpot(1, 7.2),
                FlSpot(2, 5.8),
                FlSpot(3, 6.0),
                FlSpot(4, 8.2),
                FlSpot(5, 7.5),
                FlSpot(6, 6.9),
              ],
              isCurved: true,
              color: Colors.blueAccent,
              barWidth: 4,
              belowBarData: BarAreaData(show: true,

                color: Colors.blueAccent.withAlpha((0.3 * 255).toInt()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
