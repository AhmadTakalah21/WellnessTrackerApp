// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// class BloodPressureStatsScreen extends StatelessWidget {
//   final List<String> timeFrames = ["1 Day", "1 Week", "1 Month", "1 Year", "All"];
//   final int selectedIndex = 0;

//    BloodPressureStatsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(
//           "Blood Pressure Stats",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Time Frame Selection
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: timeFrames.map((time) {
//                   bool isSelected = timeFrames.indexOf(time) == selectedIndex;
//                   return GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.black : Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(
//                         time,
//                         style: TextStyle(color: isSelected ? Colors.white : Colors.black),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
          
//               SizedBox(height: 20),
          
//               // Blood Pressure Chart
//               SizedBox(
//                 height: 180,
//                 child: Card(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: BarChart(
//                       BarChartData(
//                         barGroups: [
//                           _buildBarGroup(0, 90, 120, 110),
//                           _buildBarGroup(1, 85, 110, 100),
//                           _buildBarGroup(2, 88, 118, 105),
//                           _buildBarGroup(3, 92, 125, 115),
//                           _buildBarGroup(4, 89, 115, 108),
//                           _buildBarGroup(5, 87, 112, 102),
//                           _buildBarGroup(6, 91, 119, 113),
//                         ],
//                         titlesData: FlTitlesData(
//                           bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               getTitlesWidget: (value, meta) {
//                                 List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
//                                 return Text(days[value.toInt()], style: TextStyle(fontSize: 12));
//                               },
//                             ),
//                           ),
//                           leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                         ),
//                         gridData: FlGridData(show: false),
//                         borderData: FlBorderData(show: false),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
          
//               SizedBox(height: 20),
          
//               // Legend
//               SizedBox(
//                 width: double.infinity,
//                 child: Card(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildLegendIndicator(Colors.blue, "Target"),
//                         SizedBox(width: 10),
//                         _buildLegendIndicator(Colors.grey, "Reached"),
//                         SizedBox(width: 10),
//                         _buildLegendIndicator(Colors.white, "Current"),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
          
//               SizedBox(height: 20),
          
//               // Disease Risks
//               Text("Disease Risks", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          
//               SizedBox(height: 15),
          
//               _buildRiskCard("Heart Failure", "High Risk. Consult Doctor.", Colors.red, "High"),
//               _buildRiskCard("Liver Failure", "Low Risk. Do Prevention.", Colors.teal, "Low"),
//               _buildRiskCard("Kidney Disease", "Medium Risk. Do Prevention.", Colors.purple, "Medium"),  _buildRiskCard("Heart Failure", "High Risk. Consult Doctor.", Colors.red, "High"),
//               _buildRiskCard("Liver Failure", "Low Risk. Do Prevention.", Colors.teal, "Low"),
//               _buildRiskCard("Kidney Disease", "Medium Risk. Do Prevention.", Colors.purple, "Medium"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Function to Create Bar Chart Groups
//   BarChartGroupData _buildBarGroup(int x, double target, double reached, double current) {
//     return BarChartGroupData(x: x, barRods: [
//       BarChartRodData(toY: target, color: Colors.blue, width: 12),
//       BarChartRodData(toY: reached, color: Colors.grey, width: 12),
//       BarChartRodData(toY: current, color: Colors.white, width: 12, borderRadius: BorderRadius.circular(5)),
//     ]);
//   }

//   // Function to Build Disease Risk Cards
//   Widget _buildRiskCard(String title, String description, Color color, String riskLevel) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withAlpha((0.1 * 255).toInt()),
//             blurRadius: 5,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: color.withAlpha((0.2 * 255).toInt()),
//             child: FaIcon(FontAwesomeIcons.heartPulse, color: color),
//           ),
//           SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 5),
//                 Text(description, style: TextStyle(fontSize: 12, color: Colors.grey)),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             decoration: BoxDecoration(
//               color: color.withAlpha((0.2 * 255).toInt()),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Text(
//               riskLevel,
//               style: TextStyle(color: color, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Function to Create Legend Indicator
//   Widget _buildLegendIndicator(Color color, String text) {
//     return Row(
//       children: [
//         Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
//         SizedBox(width: 5),
//         Text(text, style: TextStyle(fontSize: 12)),
//       ],
//     );
//   }
// }
