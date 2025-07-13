// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

// class HabitSummaryScreen extends StatelessWidget {
//   const HabitSummaryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "All Habits Summary",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircularPercentIndicator(
//                 radius: 80.0,
//                 lineWidth: 13.0,
//                 animation: true,
//                 percent: 0.5,
//                 center: const Text(
//                   "50%",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//                 ),
//                 circularStrokeCap: CircularStrokeCap.round,
//                 progressColor: Colors.blueAccent,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 StatCard("🏆 Best Streak", "25 days"),
//                 StatCard("✅ Completed", "25"),
//                 StatCard("❌ Not Done", "5"),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "🔥 Best habit this week",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             _BestHabitCard(),
//             const SizedBox(height: 20),
//             const Text(
//               "📅 Upcoming Habits",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             _upcomingHabit(
//               "Morning Jog",
//               "6:30 AM",
//               Icons.directions_run,
//               Colors.orange,
//             ),
//             _upcomingHabit(
//               "Meditation",
//               "8:00 AM",
//               Icons.self_improvement,
//               Colors.green,
//             ),
//             _upcomingHabit("Reading", "9:00 PM", Icons.menu_book, Colors.blue),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class StatCard extends StatelessWidget {
//   final String title, value;
//   const StatCard(this.title, this.value, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
//       ),
//       child: Column(
//         children: [
//           Text(
//             value,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 5),
//           Text(title, style: TextStyle(color: Colors.grey.shade600)),
//         ],
//       ),
//     );
//   }
// }

// class _BestHabitCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: const CircleAvatar(
//           backgroundColor: Colors.yellow,
//           child: Text("🏅"),
//         ),
//         title: const Text(
//           "Do Morning Vacuum",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: const Text("70% Completion Rate - 7 Check-ins"),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//       ),
//     );
//   }
// }

// Widget _upcomingHabit(String title, String time, IconData icon, Color color) {
//   return Card(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     child: ListTile(
//       leading: CircleAvatar(
//         backgroundColor: color.withAlpha((0.2 * 255).toInt()),
//         child: Icon(icon, color: color),
//       ),
//       title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//       subtitle: Text("Reminder: $time"),
//     ),
//   );
// }
