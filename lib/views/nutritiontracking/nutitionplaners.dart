// import 'package:flutter/material.dart';
// import '../../Widgets/custombtn.dart';
// import 'nutritionplans.dart';

// class NutritionPlannerScreen extends StatelessWidget {
//   final List<String> days = ["20", "21", "22", "23", "24", "25"];
//   final List<String> weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri"];
//   final int selectedDayIndex = 1;

//    NutritionPlannerScreen({super.key}); // Active day (21st)

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         centerTitle: true,
//         title: Text("October", style: TextStyle(color: Colors.black, fontSize: 18)),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Date Selector
//             Card(
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(13.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(days.length, (index) {
//                     bool isActive = index == selectedDayIndex;
//                     return Column(
//                       children: [
//                         Text(weekDays[index], style: TextStyle(color: Colors.grey[600])),
//                         SizedBox(height: 4),
//                         Container(
//                           padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                           decoration: BoxDecoration(
//                             color: isActive ? Colors.green[100] : Colors.transparent,
//                             borderRadius: BorderRadius.circular(10),
//                             border: isActive ? Border.all(color: Colors.green, width: 2) : Border.all(color: Colors.transparent),
//                           ),
//                           child: Text(days[index], style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? Colors.green : Colors.black)),
//                         ),
//                       ],
//                     );
//                   }),
//                 ),
//               ),
//             ),

//             // Nutrition Summary
//             Card(
//               color: Colors.white,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               elevation: 2,
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     Text("Daily Nutrition Goals", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         NutrientTile(label: "Calories", value: "1,800 kcal"),
//                         NutrientTile(label: "Protein", value: "120g"),
//                         NutrientTile(label: "Carbs", value: "200g"),
//                         NutrientTile(label: "Fats", value: "50g"),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Meal Plan List
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     NutritionTile(time: "7:00 AM", title: "Breakfast", subtitle: "Oatmeal & Berries", details: "350 kcal"),
//                     NutritionTile(time: "10:00 AM", title: "Snack", subtitle: "Greek Yogurt & Almonds", details: "200 kcal"),
//                     NutritionTile(time: "1:00 PM", title: "Lunch", subtitle: "Grilled Chicken & Quinoa", details: "500 kcal"),
//                     NutritionTile(time: "4:00 PM", title: "Snack", subtitle: "Protein Shake", details: "250 kcal"),
//                     NutritionTile(time: "7:00 PM", title: "Dinner", subtitle: "Salmon & Steamed Veggies", details: "500 kcal"),
//                     NutritionTile(time: "9:30 PM", title: "Snack", subtitle: "Cottage Cheese & Nuts", details: "100 kcal"),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         child: CustomButton(text: 'Add Nutrition Plan', onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (_) => NutritionPlansScreen()));
//         }),
//       ),
//     );
//   }
// }

// class NutrientTile extends StatelessWidget {
//   final String label;
//   final String value;

//   const NutrientTile({super.key, required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         Text(label, style: TextStyle(color: Colors.grey, fontSize: 14)),
//       ],
//     );
//   }
// }

// class NutritionTile extends StatelessWidget {
//   final String time;
//   final String title;
//   final String subtitle;
//   final String details;

//   const NutritionTile({super.key, required this.time, required this.title, required this.subtitle, required this.details});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text(time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54)),
//             SizedBox(width: 10),
//             Expanded(
//               child: Card(
//                 color: Colors.blue[100],
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 2,
//                 child: Padding(
//                   padding: EdgeInsets.all(12),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                           Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.black54)),
//                         ],
//                       ),
//                       Text(details, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }
