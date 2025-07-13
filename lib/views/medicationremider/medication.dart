// import 'package:flutter/material.dart';

// import 'details.dart';

// class MedicationReminderScreen extends StatefulWidget {
//   const MedicationReminderScreen({super.key});

//   @override
//   MedicationReminderScreenState createState() =>
//       MedicationReminderScreenState();
// }

// class MedicationReminderScreenState extends State<MedicationReminderScreen> {
//   int selectedDay = 7;

//   List<Map<String, dynamic>> medicines = [
//     {
//       "name": "Paracetamol XL2",
//       "time": ["After Breakfast", "After Dinner"],
//       "icon": Icons.medication,
//       "color": Colors.blue,
//     },
//     {
//       "name": "Abacavir",
//       "time": ["Before Lunch", "After Dinner"],
//       "icon": Icons.local_pharmacy,
//       "color": Colors.green,
//     },
//     {
//       "name": "Dpp-4 inhibitors",
//       "time": ["Before Lunch", "After Dinner"],
//       "icon": Icons.medical_services,
//       "color": Colors.red,
//     },
//     {
//       "name": "Amrinone",
//       "time": ["Before Lunch", "After Dinner"],
//       "icon": Icons.vaccines,
//       "color": Colors.orange,
//     },
//     {
//       "name": "Metformin",
//       "time": ["After Lunch"],
//       "icon": Icons.medication,
//       "color": Colors.purple,
//     },
//     {
//       "name": "Ibuprofen",
//       "time": ["Morning", "Evening"],
//       "icon": Icons.local_hospital,
//       "color": Colors.teal,
//     },
//     {
//       "name": "Antibiotics",
//       "time": ["After Dinner"],
//       "icon": Icons.healing,
//       "color": Colors.brown,
//     },
//     {
//       "name": "Cough Syrup",
//       "time": ["Before Bed"],
//       "icon": Icons.science,
//       "color": Colors.blueGrey,
//     },
//     {
//       "name": "Vitamin D",
//       "time": ["Morning"],
//       "icon": Icons.light_mode,
//       "color": Colors.deepPurple,
//     },
//     {
//       "name": "Insulin Injection",
//       "time": ["Before Meals"],
//       "icon": Icons.bloodtype,
//       "color": Colors.deepOrange,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             Text(
//               "Your Medicines\nReminder",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),

//             // Calendar Section
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: List.generate(7, (index) {
//                 int day = 6 + index;
//                 return GestureDetector(
//                   onTap: () => setState(() => selectedDay = day),
//                   child: Column(
//                     children: [
//                       Text(
//                         [
//                           "Sun",
//                           "Mon",
//                           "Tue",
//                           "Wed",
//                           "Thu",
//                           "Fri",
//                           "Sat",
//                         ][index],
//                         style: TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color:
//                               selectedDay == day
//                                   ? Colors.pinkAccent
//                                   : Colors.white,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child: Text(
//                           "$day",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color:
//                                 selectedDay == day
//                                     ? Colors.white
//                                     : Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ),

//             SizedBox(height: 20),

//             // Tabs
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children:
//                   ["Today", "Week", "Month"].map((tab) {
//                     return GestureDetector(
//                       onTap: () {},
//                       child: Text(
//                         tab,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: tab == "Today" ? Colors.black : Colors.grey,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//             ),

//             SizedBox(height: 20),

//             // Medicine List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: medicines.length,
//                 itemBuilder: (context, index) {
//                   var medicine = medicines[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => MedicineDetailsScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 12),
//                       padding: EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: medicine["color"].withOpacity(0.2),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               medicine["icon"],
//                               size: 30,
//                               color: medicine["color"],
//                             ),
//                           ),
//                           SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   medicine["name"],
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 5),
//                                 Row(
//                                   children:
//                                       medicine["time"].map<Widget>((time) {
//                                         return Container(
//                                           margin: EdgeInsets.only(right: 8),
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: 10,
//                                             vertical: 5,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: medicine["color"]
//                                                 .withOpacity(0.2),
//                                             borderRadius: BorderRadius.circular(
//                                               8,
//                                             ),
//                                           ),
//                                           child: Text(
//                                             time,
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: medicine["color"],
//                                             ),
//                                           ),
//                                         );
//                                       }).toList(),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Icon(Icons.more_vert, color: Colors.grey),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
