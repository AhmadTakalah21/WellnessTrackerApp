// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';



// class CurrentHydrationScreen extends StatefulWidget {
//   const CurrentHydrationScreen({super.key});

//   @override
//   CurrentHydrationScreenState createState() => CurrentHydrationScreenState();
// }

// class CurrentHydrationScreenState extends State<CurrentHydrationScreen> {
//   double hydrationPercentage = 75;
//   double hydrationAmount = 1500;
//   final double dailyGoal = 2000;
//   List<String> drinkHistory = [];

//   void addWater(double amount, String drinkType) {
//     setState(() {
//       hydrationAmount += amount;
//       hydrationPercentage = (hydrationAmount / dailyGoal) * 100;
//       drinkHistory.insert(0, "$drinkType - ${amount.toInt()}ml");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 20),

//             Text(
//               "Current Hydration",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   height: 160,
//                   width: 160,
//                   child: CircularProgressIndicator(
//                     value: hydrationPercentage / 100,
//                     strokeWidth: 12,
//                     backgroundColor: Colors.grey[200],
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       "${hydrationPercentage.toInt()}%",
//                       style:
//                       TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
//                     Text("${hydrationAmount.toInt()} ml / ${dailyGoal.toInt()} ml"),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Text("Add a Drink", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//             SizedBox(height: 10),
//             GridView.count(
//               crossAxisCount: 3,
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               mainAxisSpacing: 5,
//               crossAxisSpacing: 3,
//               children: [
//                 buildDrinkCard(FontAwesomeIcons.droplet, "Water", 250),
//                 buildDrinkCard(FontAwesomeIcons.wineBottle, "Juice", 300),
//                 buildDrinkCard(FontAwesomeIcons.mugHot, "Coffee", 180),
//                 buildDrinkCard(FontAwesomeIcons.whiskeyGlass, "Tea", 200),
//                 buildDrinkCard(FontAwesomeIcons.beerMugEmpty, "Soda", 350),
//                 buildDrinkCard(FontAwesomeIcons.bolt, "EnergyDrink", 250),
//               ],
//             ),
//             SizedBox(height: 7),

//             Text("Drink History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: drinkHistory.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     leading: Icon(Icons.local_drink, color: Colors.blue),
//                     title: Text(drinkHistory[index]),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
      
//     );
//   }

//   Widget buildDrinkCard(IconData icon, String label, double amount) {
//     return GestureDetector(
//       onTap: () => addWater(amount, label),
//       child: Container(
//         margin: EdgeInsets.all(2),
//         padding: EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: Colors.blue.withAlpha((0.1 * 255).toInt()),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FaIcon(icon, size: 30, color: Colors.blue),
//             SizedBox(height: 8),
//             Text(label, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }
// }
