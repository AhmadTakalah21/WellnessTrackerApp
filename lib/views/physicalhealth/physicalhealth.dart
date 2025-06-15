import 'package:flutter/material.dart';



class PhysicalHealth extends StatelessWidget {
  const PhysicalHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("PhysicalHealth", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressCard(),
              SizedBox(height: 10),
              _buildDailyGoals(),
              _buildActivityMetrics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color:Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current State", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple)),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildGoalTile("8", "Days", "Target: 24 days"),
                _buildGoalTile("89", "kg", "Target: 78 kg"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalTile(String value, String label, String target) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple)),
        Text(label, style: TextStyle(fontSize: 16, color: Colors.black87)),
        Text(target, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDailyGoals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Daily Goals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Set up", style: TextStyle(fontSize: 14, color: Colors.purple)),
          ],
        ),
        SizedBox(height: 12),
        _buildGoalProgress("Total Calories", 0.72, Colors.orange, Icons.fastfood),
        _buildGoalProgress("Water Balance", 0.36, Colors.blue, Icons.local_drink),
        _buildGoalProgress("Lose Weight", 0.94, Colors.green, Icons.fitness_center),
        _buildGoalProgress("Sleep Quality", 0.85, Colors.purple, Icons.bedtime),
        _buildGoalProgress("Exercise", 0.60, Colors.red, Icons.directions_run),
      ],
    );
  }

  Widget _buildGoalProgress(String label, double progress, Color color, IconData icon) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
                backgroundColor: color.withAlpha((0.2 * 255).toInt()),
                child: Icon(icon, color: color)),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  LinearProgressIndicator(value: progress, backgroundColor: Colors.grey.shade300, color: color, minHeight: 6),
                ],
              ),
            ),
            SizedBox(width: 10),
            Text("${(progress * 100).toInt()}%", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Activity Metrics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 2.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildMetricTile("Heart Rate", "96 Bpm", Colors.red, Icons.favorite),
            _buildMetricTile("Water", "1200 ml", Colors.blue, Icons.local_drink),
            _buildMetricTile("Steps", "4352", Colors.orange, Icons.directions_walk),
            _buildMetricTile("Sleep", "7h 36m", Colors.purple, Icons.bedtime),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricTile(String label, String value, Color color, IconData icon) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12),
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
