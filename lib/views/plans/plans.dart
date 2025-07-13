// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:table_calendar/table_calendar.dart';



// class ActivityPlanScreen extends StatefulWidget {
//   const ActivityPlanScreen({super.key});

//   @override
//   State<ActivityPlanScreen> createState() => _ActivityPlanScreenState();
// }

// class _ActivityPlanScreenState extends State<ActivityPlanScreen> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("My Plan", style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16),
//             child: DropdownButton<String>(
//               underline: Container(),
//               value: "Weekly",
//               items: const [DropdownMenuItem(value: "Weekly", child: Text("Weekly"))],
//               onChanged: (value) {},
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Calendar Placeholder
//             SizedBox(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withAlpha((0.1 * 255).toInt()),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.all(12),
//                 child: TableCalendar(
//                   focusedDay: _focusedDay,
//                   firstDay: DateTime(2020, 1, 1),
//                   lastDay: DateTime(2030, 12, 31),
//                   selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//                   onDaySelected: (selectedDay, focusedDay) {
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                     });
//                   },
//                   calendarStyle: CalendarStyle(
//                     todayDecoration: BoxDecoration(
//                       color: Colors.orange.shade700,
//                       shape: BoxShape.circle,
//                     ),
//                     selectedDecoration: BoxDecoration(
//                       color: Colors.redAccent,
//                       shape: BoxShape.circle,
//                     ),
//                     defaultTextStyle: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   headerStyle: HeaderStyle(
//                     formatButtonVisible: false,
//                     titleCentered: true,
//                     leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black54),
//                     rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black54),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView(
//                 children: [
//                   buildActivityCard(
//                     title: "Yoga",
//                     subtitle: "5 exercises",
//                     icon: FontAwesomeIcons.personPraying,
//                     progress: 0.7,
//                     gradientColors: [Colors.orangeAccent, Colors.deepOrange],
//                   ),
//                   buildActivityCard(
//                     title: "Cycling",
//                     subtitle: "10 - 25 km",
//                     icon: FontAwesomeIcons.bicycle,
//                     progress: 0.5,
//                     gradientColors: [Colors.redAccent, Colors.red],
//                   ),
//                   buildActivityCard(
//                     title: "Sleeping",
//                     subtitle: "6 - 8 hours",
//                     icon: FontAwesomeIcons.bed,
//                     progress: 0.8,
//                     gradientColors: [Colors.blueAccent, Colors.blue],
//                   ),
//                   buildActivityCard(
//                     title: "Office",
//                     subtitle: "8+ hours",
//                     icon: FontAwesomeIcons.briefcase,
//                     progress: 0.9,
//                     gradientColors: [Colors.purpleAccent, Colors.purple],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildActivityCard({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required double progress,
//     required List<Color> gradientColors,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
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
//               CircleAvatar(
//                 radius: 24,
//                 backgroundColor: Colors.white.withAlpha((0.2 * 255).toInt()),
//                 child: Icon(icon, color: Colors.white, size: 28),
//               ),
//               const SizedBox(width: 12),
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
//                     subtitle,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
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
//                   valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
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