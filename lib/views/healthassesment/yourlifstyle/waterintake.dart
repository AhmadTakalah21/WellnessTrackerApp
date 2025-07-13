// import 'package:flutter/material.dart';

// class WaterIntakeScreen extends StatefulWidget {
//   const WaterIntakeScreen({super.key});

//   @override
//   WaterIntakeScreenState createState() => WaterIntakeScreenState();
// }

// class WaterIntakeScreenState extends State<WaterIntakeScreen> {
//   int selectedOption = 0; // Default selection

//   final List<String> waterIntakeOptions = [
//     "Less than 1 liter",
//     "1-2 liters",
//     "2-3 liters",
//     "More than 3 liters",
//   ];

//   // void _navigateToNextScreen() {
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => DietaryPreferencesScreen(),
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,

//         centerTitle: true,
//         title: const Text("Water Intake",style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.deepPurple,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Question Text
//             const Text(
//               "How much water do you drink daily?",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),

//             // Options List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: waterIntakeOptions.length,
//                 itemBuilder: (context, index) {
//                   bool isSelected = selectedOption == index;
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedOption = index;
//                       });
//                     },
//                     child: AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.deepPurple.shade100 : Colors.white,
//                         border: Border.all(
//                           color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
//                           width: isSelected ? 2 : 1,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           if (isSelected)
//                             BoxShadow(
//                               color: Colors.deepPurple.shade100,
//                               blurRadius: 10,
//                               spreadRadius: 2,
//                             ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
//                             color: isSelected ? Colors.deepPurple : Colors.grey,
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Text(
//                               waterIntakeOptions[index],
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: isSelected ? Colors.deepPurple.shade800 : Colors.black87,
//                                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Next Button at the Bottom
//             // SizedBox(
//             //   width: double.infinity,
//             //   child: ElevatedButton(
//             //     onPressed: _navigateToNextScreen,
//             //     style: ElevatedButton.styleFrom(
//             //       backgroundColor: Colors.deepPurple,
//             //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             //       padding: const EdgeInsets.symmetric(vertical: 16),
//             //     ),
//             //     child: const Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // NEXT SCREEN
// class NextScreen extends StatelessWidget {
//   final String selectedOption;

//   const NextScreen({super.key, required this.selectedOption});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Next Screen"), backgroundColor: Colors.deepPurple),
//       body: Center(
//         child: Text(
//           "You selected: $selectedOption",
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
