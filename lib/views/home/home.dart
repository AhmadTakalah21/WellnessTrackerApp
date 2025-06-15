// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../activitiestracking/actvity.dart';
// import '../bloodpressuretracking/bloodpressuretracker.dart';
// import '../daillygoals/daillygoals.dart';
// import '../exercisetracker/exercise.dart';
// import '../habittracker/habittracker.dart';
// import '../heartrater/heartrate.dart';
// import '../hyderationtracking/hyderation.dart';
// import '../mealtracking/mealtracking.dart';
// import '../medicationremider/medication.dart';
// import '../meditation/meditation.dart';
// import '../mentalwellbeing/mentalwellbeing.dart';
// import '../moodtracker/mood.dart';
// import '../notifications/notifications.dart';
// import '../nutritiontracking/nutritiontracking.dart';
// import '../personalizedplansgeneration/personlizedplans.dart';
// import '../physicalhealth/physicalhealth.dart';
// import '../plans/plans.dart';
// import '../sleeptracking/sleeptracking.dart';
// import '../stepstrcking/stepstracking.dart';
// import '../stressmanagement/stressmanagement.dart';
// import '../userprofilesetup/userprofile.dart';
// import '../weighttracker/weighttracker.dart';
// import '../yogatracker/yogatracker.dart';
// import '../messages/chat_screen.dart';
// import '../reviews/reviews.dart';

// class DashboardScreen extends StatelessWidget {
//   final List<Color> iconColors = [
//     Colors.red,
//     Colors.blue,
//     Colors.green,
//     Colors.orange,
//     Colors.purple,
//     Colors.cyan,
//     Colors.teal,
//     Colors.amber,
//     Colors.pink,
//     Colors.indigo,
//     Colors.lime,
//     Colors.brown,
//     Colors.deepOrange,
//     Colors.deepPurple,
//     Colors.lightBlue,
//     Colors.lightGreen,
//     Colors.yellow,
//     Colors.grey,
//     Colors.blueGrey,
//     Colors.redAccent,
//     Colors.greenAccent,
//     Colors.orangeAccent,
//     Colors.purpleAccent,
//     Colors.tealAccent,
//   ];

//   final Map<String, dynamic> modules = {
//     "Activities": {"icon": FontAwesomeIcons.personRunning, "screen": ActivityScreen()},
//     "Blood Pressure": {"icon": FontAwesomeIcons.heartPulse, "screen": Bp1()},
//     "Daily Goals": {"icon": FontAwesomeIcons.listCheck, "screen": DailyGoalsScreen()},
//     "Exercise": {"icon": FontAwesomeIcons.dumbbell, "screen": ExerciseTrackerScreennnn()},
//     "Habit": {"icon": FontAwesomeIcons.checkDouble, "screen": HabitTrackerScreen()},
//     "Heart Rate": {"icon": FontAwesomeIcons.heartPulse, "screen": Heart1()},
//     "Hydration": {"icon": FontAwesomeIcons.glassWater, "screen": Hyderation1()},
//     "Meal": {"icon": FontAwesomeIcons.utensils, "screen": MealTrackingScreen()},
//     "Medication": {"icon": FontAwesomeIcons.pills, "screen": MedicationReminderScreen()},
//     "Meditation": {"icon": FontAwesomeIcons.om, "screen": MeditationScreen()},
//     "Mental": {"icon": FontAwesomeIcons.brain, "screen": MentalWellbeingScreen()},
//     "Mood": {"icon": FontAwesomeIcons.faceSmile, "screen": MoodTrackerScreen()},
//     "Nutrition": {"icon": FontAwesomeIcons.appleWhole, "screen": NutritionTrackingScreen()},
//     "Personalized": {"icon": FontAwesomeIcons.fileSignature, "screen": PersonalizedPlanScreen()},
//     "Physical": {"icon": FontAwesomeIcons.personWalking, "screen": PhysicalHealth()},
//     "Plans": {"icon": FontAwesomeIcons.calendarCheck, "screen": ActivityPlanScreen()},
//     "Reviews": {"icon": FontAwesomeIcons.star, "screen": Reviews()},
//     "Sleep": {"icon": FontAwesomeIcons.moon, "screen": SleepCalendarScreen()},
//     "Steps": {"icon": FontAwesomeIcons.shoePrints, "screen": StepTrackerScreen()},
//     "Stress": {"icon": FontAwesomeIcons.spa, "screen": StressManagement()},
//     "Profile ": {"icon": FontAwesomeIcons.userPen, "screen": UserProfileSetupScreen()},
//     "Weight": {"icon": FontAwesomeIcons.weightScale, "screen": WeightTrackerr()},
//     "Yoga": {"icon": FontAwesomeIcons.personPraying, "screen": YogaTrackerScreen()},
//     "Notifications": {"icon": FontAwesomeIcons.bell, "screen": CryptoNotifications()},
//     "Messages": {"icon": FontAwesomeIcons.commentDots, "screen": ChatScreen()},
//   };

//    DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(

//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.favorite, color: Colors.white, size: 24), // Attractive icon
//             const SizedBox(width: 8),
//             const Text(
//               "Wellness Tracker App",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//                 letterSpacing: 1.2,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         elevation: 4, // Slight shadow for depth

//       ),


//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 4,
//             mainAxisSpacing: 3,
//           ),
//           itemCount: modules.length,
//           itemBuilder: (context, index) {
//             String moduleName = modules.keys.elementAt(index);
//             return _buildGridItem(context, moduleName, modules[moduleName], iconColors[index % iconColors.length]);
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildGridItem(BuildContext context, String name, Map<String, dynamic> module, Color color) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => module["screen"]),
//         );
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 3,
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: color.withAlpha((0.2 * 255).toInt()),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(module["icon"], size: 37, color: color),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               name,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
