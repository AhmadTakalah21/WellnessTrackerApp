// import 'package:flutter/material.dart';
// import 'package:pregnancytrackerapp/views/ChatFlow/chat_screen.dart';
// import 'package:pregnancytrackerapp/views/Reviews/reviews.dart';
// import 'package:pregnancytrackerapp/views/calendar/calendar.dart';
// import 'package:pregnancytrackerapp/views/home/home.dart';
// import 'package:pregnancytrackerapp/views/profile/profilescreen.dart';
// import 'package:pregnancytrackerapp/views/timelinescreen/timelinescreen.dart';
// import 'package:pregnancytrackerapp/views/trackingtools/trackingtools.dart';
// import '../views/insights/insights.dart';
//
// class BottomNavBarScreen extends StatefulWidget {
//   const BottomNavBarScreen({super.key});
//
//   @override
//   BottomNavBarScreenState createState() => BottomNavBarScreenState();
// }
//
// class BottomNavBarScreenState extends State<BottomNavBarScreen> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _screens = [
//     HomeScreen(),
//     TrackingToolsScreen(),
//     CalendarScreen(),
//     TimelineScreen(),
//     InsightsScreen(),
//     ChatScreen(),
//     Reviews(),
//     ProfileScreen()
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blueAccent, Colors.purpleAccent],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, -3),
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           items: [
//             _buildBottomNavBarItem(Icons.home, 'Home'),
//             _buildBottomNavBarItem(Icons.pregnant_woman, 'Pregnancy Tracking'),
//             _buildBottomNavBarItem(Icons.calendar_today, 'Calendar'),
//             _buildBottomNavBarItem(Icons.timeline, 'Timeline'),
//             _buildBottomNavBarItem(Icons.lightbulb, 'Insights'),
//             _buildBottomNavBarItem(Icons.chat, 'Chats'),
//             _buildBottomNavBarItem(Icons.reviews, 'Reviews'),
//             _buildBottomNavBarItem(Icons.person, 'Profile'),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.white70,
//           showUnselectedLabels: true,
//           onTap: _onItemTapped,
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.transparent, // Transparent background to apply gradient
//         ),
//       ),
//     );
//   }
//
//   BottomNavigationBarItem _buildBottomNavBarItem(IconData icon, String label) {
//     return BottomNavigationBarItem(
//       icon: _buildAnimatedIcon(icon),
//       label: label,
//     );
//   }
//
//   Widget _buildAnimatedIcon(IconData iconData) {
//     return AnimatedSwitcher(
//       duration: const Duration(milliseconds: 200),
//       transitionBuilder: (Widget child, Animation<double> animation) {
//         return ScaleTransition(
//           scale: animation,
//           child: child,
//         );
//       },
//       child: Icon(
//         iconData,
//         key: ValueKey<IconData>(iconData),
//         size: 30,
//       ),
//     );
//   }
// }
