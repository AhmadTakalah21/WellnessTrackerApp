// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:fl_chart/fl_chart.dart';


// class BRMStatsApp extends StatelessWidget {
//   const BRMStatsApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HeartStatsScreen(),
//     );
//   }
// }

// class HeartStatsScreen extends StatelessWidget {
//   final List<Color> barColors = [
//     Colors.pink, // Monday
//     Colors.yellow, // Tuesday
//     Colors.blue, // Wednesday
//     Colors.purple, // Thursday
//     Colors.green, // Friday
//     Colors.orange, // Saturday
//   ];

//    HeartStatsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF4F2FA),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.menu, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),

//             // Date and BRM Overview
//             Container(
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Color(0xFF0D0D25),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "28 Aug '23",
//                     style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 15),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _buildBRMInfo(FontAwesomeIcons.solidHeart, "95", "Average", Colors.pink),
//                       _buildBRMInfo(FontAwesomeIcons.solidStar, "107", "Maximum", Colors.yellow),
//                       _buildBRMInfo(FontAwesomeIcons.heart, "85", "Minimum", Colors.blue),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 30),

//             // Timeframe Toggle
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _timeframeButton("Day", true),
//                 _timeframeButton("Week", false),
//                 _timeframeButton("Month", false),
//               ],
//             ),

//             SizedBox(height: 20),

//             // BRM Chart
//             Expanded(
//               child: BarChart(
//                 BarChartData(
//                   barGroups: List.generate(6, (index) {
//                     return _buildBarGroup(index, _getBRMValue(index), barColors[index]);
//                   }),
//                   borderData: FlBorderData(show: false),
//                   gridData: FlGridData(show: false),
//                   titlesData: FlTitlesData(
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: true, reservedSize: 40),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (double value, TitleMeta meta) {
//                           List<String> labels = ["M", "T", "W", "T", "F", "S"];
//                           return Text(labels[value.toInt()], style: TextStyle(color: Colors.black));
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget for BRM Info
//   Widget _buildBRMInfo(IconData icon, String value, String label, Color color) {
//     return Column(
//       children: [
//         FaIcon(icon, color: color, size: 20),
//         SizedBox(height: 5),
//         Text(value, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
//         Text(label, style: TextStyle(color: Colors.white70, fontSize: 14)),
//       ],
//     );
//   }

//   // Timeframe Button
//   Widget _timeframeButton(String label, bool isSelected) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.black : Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.black),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 16),
//       ),
//     );
//   }

//   // Bar Group for Chart with Different Colors
//   BarChartGroupData _buildBarGroup(int x, double y, Color color) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: y,
//           color: color,
//           width: 15,
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ],
//     );
//   }

//   // Example BRM Data for Each Day
//   double _getBRMValue(int index) {
//     List<double> values = [80, 95, 107, 85, 92, 100];
//     return values[index];
//   }
// }
