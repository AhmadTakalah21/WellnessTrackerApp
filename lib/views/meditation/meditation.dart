// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:wellnesstrackerapp/Widgets/custombtn.dart';
// import 'package:wellnesstrackerapp/views/meditation/meditation2.dart';



// class MeditationScreen extends StatelessWidget {
//   const MeditationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Meditation", style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700)),
//         centerTitle: true,

//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("4 Exercises are waiting", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 16),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.deepPurple.shade100,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Mindfulness Meditation", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                       SizedBox(height: 4),
//                       Text("Instructor: Joe Serliano", style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                   Icon(FontAwesomeIcons.spa, color: Colors.deepPurple),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Text("Weekly Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Expanded(
//               child: GridView.count(
//                 shrinkWrap: true,
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 2,
//                 children: [
//                   _buildStatCard("22", "Completed", FontAwesomeIcons.circleCheck, Colors.green),
//                   _buildStatCard("8", "In Progress", FontAwesomeIcons.hourglassHalf, Colors.orange),
//                   _buildStatCard("3", "Ongoing", FontAwesomeIcons.spinner, Colors.blue),
//                   _buildStatCard("10", "Next Week", FontAwesomeIcons.calendar, Colors.purple),
//                   _buildStatCard("5", "Missed", FontAwesomeIcons.circleXmark, Colors.red),
//                   _buildStatCard("15", "Total Sessions", FontAwesomeIcons.chartBar, Colors.teal),
//                   _buildStatCard("7", "Pending Review", FontAwesomeIcons.eye, Colors.deepOrange),
//                   _buildStatCard("12", "Goal Achieved", FontAwesomeIcons.trophy, Colors.amber),
//                   _buildStatCard("6", "Reattempted", FontAwesomeIcons.arrowRotateRight, Colors.indigo),
//                   _buildStatCard("18", "New Activities", FontAwesomeIcons.bolt, Colors.cyan),
              
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: CustomButton(text: 'Next', onTap: (){
//           Navigator.push(context, MaterialPageRoute(builder: (_)=>Meditation2Screen()));

//         }),
//       ),
//     );
//   }

//   Widget _buildStatCard(String count, String label, IconData icon, Color iconColor) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               SizedBox(height: 4),
//               Text(label, style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//           Icon(icon, color: iconColor, size: 28),
//         ],
//       ),
//     );
//   }
// }
