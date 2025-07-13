// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';



// class MoodMonitoringScreen extends StatelessWidget {
//   final List<MoodEntry> moods = [
//     MoodEntry(date: "13", mood: "Awesome", time: "11:30 pm", icon: FontAwesomeIcons.faceSmile, color: Colors.green),
//     MoodEntry(date: "14", mood: "Good", time: "10:00 am", icon: FontAwesomeIcons.faceLaugh, color: Colors.blue),
//     MoodEntry(date: "15", mood: "Okay", time: "05:00 pm", icon: FontAwesomeIcons.faceMeh, color: Colors.orange),
//     MoodEntry(date: "16", mood: "Bad", time: "09:00 pm", icon: FontAwesomeIcons.faceFrown, color: Colors.red),
//     MoodEntry(date: "17", mood: "Lazy", time: "02:00 pm", icon: FontAwesomeIcons.faceTired, color: Colors.purple),
//     MoodEntry(date: "18", mood: "Terrible", time: "07:00 am", icon: FontAwesomeIcons.faceSadTear, color: Colors.brown),
//     MoodEntry(date: "19", mood: "Angry", time: "03:00 pm", icon: FontAwesomeIcons.faceAngry, color: Colors.deepOrange),
//   ];

//    MoodMonitoringScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {},
//         ),
//         title: Text("Mood Monitoring", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         actions: [
//           IconButton(
//             icon: Icon(FontAwesomeIcons.calendarDays, color: Colors.black),
//             onPressed: () {},
//           )
//         ],
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Let's Track...", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: moods.length,
//                 itemBuilder: (context, index) {
//                   return MoodItem(mood: moods[index]);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MoodEntry {
//   final String date;
//   final String mood;
//   final String time;
//   final IconData icon;
//   final Color color;

//   MoodEntry({required this.date, required this.mood, required this.time, required this.icon, required this.color});
// }

// class MoodItem extends StatelessWidget {
//   final MoodEntry mood;

//   const MoodItem({super.key, required this.mood});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       margin: EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       elevation: 2,
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: mood.color.withAlpha((0.2 * 255).toInt()),
//           child: Icon(mood.icon, color: mood.color),
//         ),
//         title: Text(mood.mood, style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(mood.time),
//         trailing: Text(
//           mood.date,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
