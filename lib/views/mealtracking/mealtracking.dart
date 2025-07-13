// import 'package:flutter/material.dart';
// import 'package:wellnesstrackerapp/Widgets/custombtn.dart';

// import 'mealplaneer.dart';

// void main() {
//   runApp(const MaterialApp(home: MealTrackingScreen()));
// }

// class MealTrackingScreen extends StatelessWidget {
//   const MealTrackingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Your Meal"),
//        centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Food Title
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               shadowColor: Colors.black26,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.white, Colors.grey[200]!], // Subtle gradient
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 8,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 padding: EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 35,
//                       backgroundColor: Colors.orangeAccent.withAlpha((0.2 * 255).toInt()),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(35),
//                         child: Image.network(
//                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5zhfnJ5Y5oPQ3CB4tC9_ekhp8b1vBV6cstA&s",
//                           fit: BoxFit.cover,
//                           height: 70,
//                           width: 70,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Orange",
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "Meal: Fresh Orange",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           "100 g",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         IconButton(
//                           icon: Icon(Icons.info_outline, color: Colors.orangeAccent),
//                           tooltip: "Nutrition Info",
//                           onPressed: () {
//                             // Show more details about nutrition
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Nutrient Inf
//             // ormation Card
//             Card(
//               color: Colors.white,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               elevation: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text("Nutritional Value", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 10),
//                     NutritionBar(title: "Carbohydrates", value: 12, color: Colors.purple, maxValue: 20),
//                     NutritionBar(title: "Protein", value: 0.9, color: Colors.orange, maxValue: 10),
//                     NutritionBar(title: "Fat", value: 0.1, color: Colors.red, maxValue: 5),
//                     NutritionBar(title: "Fiber", value: 2.4, color: Colors.green, maxValue: 10),
//                     NutritionBar(title: "Sugar", value: 9, color: Colors.pink, maxValue: 15),
//                     NutritionBar(title: "Water", value: 86, color: Colors.blue, maxValue: 100),
//                     const SizedBox(height: 16),
//                     const Text("Vitamins & Minerals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 10),
//                     GridView.count(
//                       crossAxisCount: 3,
//                       shrinkWrap: true,
//                       childAspectRatio: 0.8,
//                       physics: const NeverScrollableScrollPhysics(),
//                       children: const [
//                         NutritionTile(title: "Vitamin A", value: "4% DV", icon: Icons.visibility, color: Colors.deepOrange),
//                         NutritionTile(title: "Vitamin C", value: "64% DV", icon: Icons.local_fire_department, color: Colors.redAccent),
//                         NutritionTile(title: "Iron", value: "1% DV", icon: Icons.bloodtype, color: Colors.brown),
//                         NutritionTile(title: "Potassium", value: "5% DV", icon: Icons.flash_on, color: Colors.orange),
//                         NutritionTile(title: "Calcium", value: "4% DV", icon: Icons.opacity, color: Colors.blue),
//                         NutritionTile(title: "Magnesium", value: "2% DV", icon: Icons.science, color: Colors.green),
//                         NutritionTile(title: "Vitamin E", value: "3% DV", icon: Icons.eco, color: Colors.teal),
//                         NutritionTile(title: "Zinc", value: "2% DV", icon: Icons.settings, color: Colors.grey),
//                         NutritionTile(title: "Sodium", value: "0.1% DV", icon: Icons.spa, color: Colors.purple),
//                       ],
//                     )

//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Add Button with Gradient

//           ],
//         ),
//       ),
//       bottomNavigationBar:   Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
//         child: CustomButton(text: 'Add to Meal', onTap: (){
//           Navigator.push(context, MaterialPageRoute(builder: (_)=>MealPlannerScreen()));


//         })
//       ),
//     );
//   }
// }

// // Widget for Nutrition Progress Bar
// class NutritionBar extends StatelessWidget {
//   final String title;
//   final double value;
//   final Color color;
//   final double maxValue;

//   const NutritionBar({super.key, required this.title, required this.value, required this.color, required this.maxValue});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//               Text("${value.toStringAsFixed(1)}g", style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
//             ],
//           ),
//           const SizedBox(height: 4),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: LinearProgressIndicator(
//               value: value / maxValue,
//               color: color,
//               backgroundColor: Colors.grey.shade300,
//               minHeight: 8,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Widget for Vitamins & Minerals Grid
// // Widget for Vitamins & Minerals Grid with Modern Design
// class NutritionTile extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color color;

//   const NutritionTile({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       shadowColor: color.withAlpha((0.3 * 255).toInt()),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               color.withAlpha((0.2 * 255).toInt()),
//               Colors.white],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: const EdgeInsets.all(12),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               CircleAvatar(
//                 backgroundColor: color.withAlpha((0.2 * 255).toInt()),
//                 radius: 22,
//                 child: Icon(icon, color: color, size: 20),
//               ),
//               const SizedBox(height: 6),
//               Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
//               const SizedBox(height: 4),
//               Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
