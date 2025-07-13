// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class NutritionPlansScreen extends StatelessWidget {
//   const NutritionPlansScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text("Nutrition Plans", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
//         elevation: 0,
//         centerTitle: true,
//         actions: [IconButton(icon: Icon(Icons.more_vert, color: Colors.black), onPressed: () {})],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16),
//             Card(
//               color: Colors.white,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               elevation: 4,
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Daily Calorie Goal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                     SizedBox(height: 12),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GoalTile(title: "2000 kcal", subtitle: "Target Calories"),
//                         GoalTile(title: "1500 kcal", subtitle: "Consumed"),
//                         GoalTile(title: "500 kcal", subtitle: "Remaining"),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 5),
//             Text("Macronutrient Breakdown", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//             Card(
//               color: Colors.white,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               elevation: 4,
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Macronutrients", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                         DropdownButton(
//                           value: "Daily",
//                           items: ["Daily", "Weekly"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//                           onChanged: (value) {},
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 5),
//                     NutritionBarChart(),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 7),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 childAspectRatio: 1.8,
//                 crossAxisSpacing: 5,
//                 mainAxisSpacing: 3,
//                 children: [
//                   MetricTile(icon: Icons.fitness_center, color: Colors.red, value: "120g", label: "Protein"),
//                   MetricTile(icon: Icons.local_fire_department, color: Colors.blue, value: "250g", label: "Carbs"),
//                   MetricTile(icon: Icons.water_drop, color: Colors.orange, value: "70g", label: "Fats"),
//                   MetricTile(icon: Icons.local_drink, color: Colors.purple, value: "2.5L", label: "Water Intake"),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class GoalTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   const GoalTile({super.key, required this.title, required this.subtitle});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
//         Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 14)),
//       ],
//     );
//   }
// }

// class MetricTile extends StatelessWidget {
//   final IconData icon;
//   final Color color;
//   final String value;
//   final String label;

//   const MetricTile({super.key, required this.icon, required this.color, required this.value, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           children: [
//             CircleAvatar(
//                 backgroundColor: color.withAlpha((0.2 * 255).toInt()),
//                 child: Icon(icon, color: color)),
//             SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NutritionBarChart extends StatelessWidget {
//   const NutritionBarChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 150,
//       child: BarChart(
//         BarChartData(
//           barGroups: List.generate(3, (index) => BarChartGroupData(
//             x: index,
//             barRods: [
//               BarChartRodData(toY: index == 0 ? 120 : index == 1 ? 250 : 70, color: Colors.blue, width: 8),
//             ],
//           )),
//           borderData: FlBorderData(show: false),
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   List<String> labels = ["Protein", "Carbs", "Fats"];
//                   return Padding(
//                     padding: EdgeInsets.only(top: 8),
//                     child: Text(labels[value.toInt()], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


