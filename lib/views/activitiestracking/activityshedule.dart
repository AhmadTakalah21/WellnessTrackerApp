// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';



// class ActivityShedule extends StatefulWidget {
//   const ActivityShedule({super.key});

//   @override
//   State<ActivityShedule> createState() => _ActivitySheduleState();
// }

// class _ActivitySheduleState extends State<ActivityShedule> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF8F9FD),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Title
//               const Padding(
//                 padding: EdgeInsets.only(left: 8),
//                 child: Text(
//                   "Calendar",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),

//               // Calendar Widget
//               SizedBox(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withAlpha((0.1 * 255).toInt()),
//                         blurRadius: 10,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   child: TableCalendar(
//                     focusedDay: _focusedDay,
//                     firstDay: DateTime(2020, 1, 1),
//                     lastDay: DateTime(2030, 12, 31),
//                     selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//                     onDaySelected: (selectedDay, focusedDay) {
//                       setState(() {
//                         _selectedDay = selectedDay;
//                         _focusedDay = focusedDay;
//                       });
//                     },
//                     calendarStyle: CalendarStyle(
//                       todayDecoration: BoxDecoration(
//                         color: Colors.orange.shade700,
//                         shape: BoxShape.circle,
//                       ),
//                       selectedDecoration: BoxDecoration(
//                         color: Colors.redAccent,
//                         shape: BoxShape.circle,
//                       ),
//                       defaultTextStyle: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     headerStyle: HeaderStyle(
//                       formatButtonVisible: false,
//                       titleCentered: true,
//                       leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black54),
//                       rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black54),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Activity Cards
//               Expanded(
//                 child: ListView(
//                   children: [
//                     buildActivityCard(
//                       title: "Walking Plan",
//                       calories: "1400 Kcal",
//                       progress: 0.75,
//                       icon: Icons.directions_walk,
//                       gradientColors: [Colors.pinkAccent, Colors.orange],
//                     ),
//                     const SizedBox(height: 12),
//                     buildActivityCard(
//                       title: "4D Run Competition",
//                       calories: "8000 Kcal",
//                       progress: 0.95,
//                       icon: Icons.directions_run,
//                       gradientColors: [Colors.purple, Colors.blueAccent],
//                     ),
//                     const SizedBox(height: 12),
//                     buildActivityCard(
//                       title: "Morning Yoga",
//                       calories: "500 Kcal",
//                       progress: 0.60,
//                       icon: Icons.self_improvement,
//                       gradientColors: [Colors.blueAccent, Colors.lightBlue],
//                     ),
//                     const SizedBox(height: 12),
//                     buildActivityCard(
//                       title: "Cycling Session",
//                       calories: "2000 Kcal",
//                       progress: 0.85,
//                       icon: Icons.pedal_bike,
//                       gradientColors: [Colors.greenAccent, Colors.teal],
//                     ),
//                     const SizedBox(height: 12),
//                     buildActivityCard(
//                       title: "Swimming Laps",
//                       calories: "3500 Kcal",
//                       progress: 0.90,
//                       icon: Icons.pool,
//                       gradientColors: [Colors.cyan, Colors.blue],
//                     ),
//                     const SizedBox(height: 12),
//                     buildActivityCard(
//                       title: "Strength Training",
//                       calories: "1800 Kcal",
//                       progress: 0.70,
//                       icon: Icons.fitness_center,
//                       gradientColors: [Colors.redAccent, Colors.deepOrange],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Activity Card Widget
//   Widget buildActivityCard({
//     required String title,
//     required String calories,
//     required double progress,
//     required IconData icon,
//     required List<Color> gradientColors,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: gradientColors,
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: gradientColors.last.withAlpha((0.3 * 255).toInt()),
//             blurRadius: 10,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               // Icon
//               CircleAvatar(
//                 radius: 24,
//                 backgroundColor: Colors.white.withAlpha((0.2 * 255).toInt()),
//                 child: Icon(icon, color: Colors.white, size: 28),
//               ),
//               const SizedBox(width: 12),
//               // Text Details
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Text(
//                     calories,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           // Progress Indicator
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 width: 40,
//                 height: 40,
//                 child: CircularProgressIndicator(
//                   value: progress,
//                   strokeWidth: 5,
//                   backgroundColor: Colors.white.withAlpha((0.2 * 255).toInt()),
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                 ),
//               ),
//               Text(
//                 "${(progress * 100).toInt()}%",
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
