// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:fl_chart/fl_chart.dart';

// void main() {
//   runApp(const MaterialApp(home: DuelScreen()));
// }

// class DuelScreen extends StatelessWidget {
//   const DuelScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Duel",
//           style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.grey.shade100,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildDuelCard(),
//             const SizedBox(height: 20),
//             buildWeeklySteps(),
//             const SizedBox(height: 20),
//             buildRecentActivity(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDuelCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               buildUserProfile(
//                 "You",
//                 "https://randomuser.me/api/portraits/women/10.jpg",
//               ),
//               const SizedBox(width: 20),
//               Column(
//                 children: [
//                   const FaIcon(
//                     FontAwesomeIcons.shoePrints,
//                     color: Colors.red,
//                     size: 18,
//                   ),
//                   Text(
//                     "Steps",
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Text(
//                     "2450 vs 4085",
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 20),
//               buildUserProfile(
//                 "Robert",
//                 "https://randomuser.me/api/portraits/men/15.jpg",
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildUserProfile(String name, String imageUrl) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 30,
//           backgroundColor: Colors.white,
//           child: ClipOval(
//             child: Image.network(
//               imageUrl,
//               width: 60,
//               height: 60,
//               fit: BoxFit.cover,
//               loadingBuilder: (context, child, loadingProgress) {
//                 if (loadingProgress == null) return child;
//                 return const CircularProgressIndicator();
//               },
//               errorBuilder:
//                   (context, error, stackTrace) =>
//                       const Icon(Icons.error, color: Colors.red),
//             ),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           name,
//           style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
//         ),
//       ],
//     );
//   }

//   Widget buildWeeklySteps() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Weekly steps",
//           style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 200,
//           child: BarChart(
//             BarChartData(
//               borderData: FlBorderData(show: false),
//               gridData: const FlGridData(show: false),
//               titlesData: FlTitlesData(
//                 leftTitles: const AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 rightTitles: const AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 topTitles: const AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (double value, TitleMeta meta) {
//                       const days = [
//                         "Mon",
//                         "Tue",
//                         "Wed",
//                         "Thu",
//                         "Fri",
//                         "Sat",
//                         "Sun",
//                       ];
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 5),
//                         child: Text(
//                           days[value.toInt()],
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       );
//                     },
//                     reservedSize: 28,
//                   ),
//                 ),
//               ),
//               barGroups: [
//                 makeBarData(0, 2000, 4000),
//                 makeBarData(1, 3000, 7000),
//                 makeBarData(2, 5000, 2000),
//                 makeBarData(3, 4000, 5000),
//                 makeBarData(4, 6000, 3000),
//                 makeBarData(5, 3000, 6000),
//                 makeBarData(6, 2500, 4500),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   BarChartGroupData makeBarData(int x, double youSteps, double opponentSteps) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: youSteps,
//           color: Colors.red,
//           width: 10,
//           borderRadius: BorderRadius.circular(6),
//         ),
//         BarChartRodData(
//           toY: opponentSteps,
//           color: Colors.green,
//           width: 10,
//           borderRadius: BorderRadius.circular(6),
//         ),
//       ],
//     );
//   }

//   Widget buildRecentActivity() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Recent activity",
//               style: GoogleFonts.poppins(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text("View all", style: GoogleFonts.poppins(color: Colors.blue)),
//           ],
//         ),
//         const SizedBox(height: 10),
//         buildActivityItem(
//           "Fast walking",
//           "10 mins",
//           "07:26 pm - 07:36 pm",
//           FontAwesomeIcons.personWalking,
//           Colors.blue,
//         ),
//         buildActivityItem(
//           "Easy walking",
//           "25 mins",
//           "07:01 pm - 07:24 pm",
//           FontAwesomeIcons.personWalking,
//           Colors.orange,
//         ),
//         buildActivityItem(
//           "Fast walking",
//           "10 mins",
//           "07:26 pm - 07:36 pm",
//           FontAwesomeIcons.personWalking,
//           Colors.blue,
//         ),
//         buildActivityItem(
//           "Easy walking",
//           "25 mins",
//           "07:01 pm - 07:24 pm",
//           FontAwesomeIcons.personWalking,
//           Colors.orange,
//         ),
//         buildActivityItem(
//           "Fast walking",
//           "10 mins",
//           "07:26 pm - 07:36 pm",
//           FontAwesomeIcons.personWalking,
//           Colors.blue,
//         ),
//         buildActivityItem(
//           "Easy walking",
//           "25 mins",
//           "07:01 pm - 07:24 pm",
//           FontAwesomeIcons.personWalking,
//           Colors.orange,
//         ),
//         buildActivityItem(
//           "Fast walking",
//           "10 mins",
//           "07:26 pm - 07:36 pm",
//           FontAwesomeIcons.personWalking,
//           Colors.blue,
//         ),
//         buildActivityItem(
//           "Easy walking",
//           "25 mins",
//           "07:01 pm - 07:24 pm",
//           FontAwesomeIcons.personWalking,
//           Colors.orange,
//         ),
//         buildActivityItem(
//           "Fast walking",
//           "10 mins",
//           "07:26 pm - 07:36 pm",
//           FontAwesomeIcons.personWalking,
//           Colors.blue,
//         ),
//         buildActivityItem(
//           "Easy walking",
//           "25 mins",
//           "07:01 pm - 07:24 pm",
//           FontAwesomeIcons.personWalking,
//           Colors.orange,
//         ),
//       ],
//     );
//   }

//   Widget buildActivityItem(
//     String title,
//     String duration,
//     String time,
//     IconData icon,
//     Color iconColor,
//   ) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: iconColor.withAlpha((0.1 * 255).toInt()),
//           radius: 20,
//           child: FaIcon(icon, color: iconColor, size: 18),
//         ),
//         title: Text(
//           title,
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         ),
//         subtitle: Text(
//           "$duration | $time",
//           style: GoogleFonts.poppins(fontSize: 12),
//         ),
//         trailing: const Icon(Icons.chevron_right),
//       ),
//     );
//   }
// }
