import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/Widgets/custombtn.dart';

import 'nutitionplaners.dart';


void main() {
  runApp(const MaterialApp(home: NutritionTrackingScreen()));
}

class NutritionTrackingScreen extends StatelessWidget {
  const NutritionTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutrition Tracker"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nutrition Overview
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              shadowColor: Colors.black26,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey[200]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Nutrition Overview",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const NutritionBar(title: "Calories", value: 1500, color: Colors.blue, maxValue: 2500),
                    const NutritionBar(title: "Carbs", value: 200, color: Colors.orange, maxValue: 300),
                    const NutritionBar(title: "Protein", value: 80, color: Colors.green, maxValue: 150),
                    const NutritionBar(title: "Fats", value: 50, color: Colors.red, maxValue: 100),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nutrition Details
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Vitamins & Minerals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      childAspectRatio: 0.7,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        NutritionTile(title: "Vitamin A", value: "50% DV", icon: Icons.visibility, color: Colors.deepOrange),
                        NutritionTile(title: "Vitamin C", value: "80% DV", icon: Icons.local_fire_department, color: Colors.redAccent),
                        NutritionTile(title: "Iron", value: "15% DV", icon: Icons.bloodtype, color: Colors.brown),
                        NutritionTile(title: "Potassium", value: "30% DV", icon: Icons.flash_on, color: Colors.orange),
                        NutritionTile(title: "Calcium", value: "40% DV", icon: Icons.opacity, color: Colors.blue),
                        NutritionTile(title: "Magnesium", value: "25% DV", icon: Icons.science, color: Colors.green),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: CustomButton(
          text: 'Track Nutrition',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => NutritionPlannerScreen()));
          },
        ),
      ),
    );
  }
}

// Widget for Nutrition Progress Bar
class NutritionBar extends StatelessWidget {
  final String title;
  final double value;
  final Color color;
  final double maxValue;

  const NutritionBar({super.key, required this.title, required this.value, required this.color, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("${value.toStringAsFixed(1)}g", style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value / maxValue,
              color: color,
              backgroundColor: Colors.grey.shade300,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for Vitamin & Mineral Tiles
class NutritionTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const NutritionTile({super.key, required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
