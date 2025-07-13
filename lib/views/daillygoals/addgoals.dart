// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../Widgets/custombtn.dart';

// class AddGoalsScreen extends StatefulWidget {
//   const AddGoalsScreen({super.key});

//   @override
//   AddGoalsScreenState createState() => AddGoalsScreenState();
// }

// class AddGoalsScreenState extends State<AddGoalsScreen> {
//   String? goalTitle;
//   String? activityType;
//   bool everyDays = false;
//   String? remindTime;
//   List<String> selectedDays = [];
//   String intensity = "Medium";
//   String? notes;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text("Add Goals", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600)),
//         centerTitle: true,
//         backgroundColor: Colors.grey.shade100,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildTextField("Goal Title", "Enter goal name", (value) => goalTitle = value),
//               SizedBox(height: 10),

//               Text("Choose Activity", style: sectionTitleStyle()),
//               Wrap(
//                 spacing: 12.0,
//                 runSpacing: 12,

//                 children: [
//                   activityButton("Walking", FontAwesomeIcons.personWalking),
//                   activityButton("Weights", FontAwesomeIcons.dumbbell),
//                   activityButton("Swimming", FontAwesomeIcons.personSwimming),
//                   activityButton("Cycling", FontAwesomeIcons.bicycle),
//                   activityButton("Running", FontAwesomeIcons.personWalking),
//                   activityButton("Yoga", FontAwesomeIcons.handsPraying),
//                 ],
//               ),
//               SizedBox(height: 20),

//               Text("Select Intensity", style: sectionTitleStyle()),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   intensityButton("Low"),
//                   intensityButton("Medium"),
//                   intensityButton("High"),
//                 ],
//               ),
//               SizedBox(height: 10),

//               buildTextField("Remind Me", "e.g. 06:00 AM", (value) => remindTime = value),
//               SizedBox(height: 10),

//               Text("Select Days", style: sectionTitleStyle()),
//               Wrap(
//                 spacing: 8,
//                 children: ["S", "M", "T", "W", "T", "F", "S"].map((day) => dayButton(day)).toList(),
//               ),
//               SizedBox(height: 20),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Every Day", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//                   Switch(
//                     value: everyDays,
//                     onChanged: (value) {
//                       setState(() {
//                         everyDays = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),

//               buildTextField("Additional Notes", "Any extra details...", (value) => notes = value, maxLines: 3),
//               SizedBox(height: 20),


//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: CustomButton(text: 'Add Goals', onTap: (){
//           // Navigator.push(context, MaterialPageRoute(builder: (_)=>AddGoalsScreen()));


//         }),
//       ),
//     );
//   }

//   Widget buildTextField(String label, String hint, Function(String) onChanged, {int maxLines = 1}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: sectionTitleStyle()),
//         SizedBox(height: 5),
//         TextFormField(
//           maxLines: maxLines,
//           decoration: InputDecoration(
//             hintText: hint,
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//             filled: true,
//             fillColor: Colors.grey[100],
//           ),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }

//   Widget activityButton(String name, IconData icon) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
//         child: Column(
//           children: [
//             FaIcon(icon, color: Colors.deepPurple, size: 24),
//             SizedBox(height: 5),
//             Text(name, style: GoogleFonts.poppins(fontSize: 14)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget intensityButton(String level) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           intensity = level;
//         });
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: intensity == level ? Colors.deepPurple : Colors.grey[300],
//         foregroundColor: intensity == level ? Colors.white : Colors.black,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       child: Text(level, style: GoogleFonts.poppins(fontSize: 14)),
//     );
//   }

//   Widget dayButton(String day) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedDays.contains(day) ? selectedDays.remove(day) : selectedDays.add(day);
//         });
//       },
//       child: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: selectedDays.contains(day) ? Colors.deepPurple : Colors.grey[200],
//           shape: BoxShape.circle,
//         ),
//         child: Center(
//           child: Text(day, style: TextStyle(color: selectedDays.contains(day) ? Colors.white : Colors.black, fontSize: 16)),
//         ),
//       ),
//     );
//   }

//   TextStyle sectionTitleStyle() {
//     return GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600);
//   }
// }