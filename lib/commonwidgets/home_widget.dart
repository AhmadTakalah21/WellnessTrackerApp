// import 'package:flutter/material.dart';
//
// import '../constants/colors.dart';
// import '../views/notifications/notifications.dart';
//
// class HomeWidgte extends StatelessWidget {
//   const HomeWidgte({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 30),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Builder(builder: (context) {
//             return InkWell(
//               onTap: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               child: const Icon(
//                 Icons.menu_outlined,
//                 color: Colors.white,
//               ),
//             );
//           }),
//           // const Text1(
//           //   text1: 'Crypto Exchange',
//           //   size: 16,
//           //   color: Colors.white,
//           // ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Noida Sector 75",
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               Text(
//                 "Golf city, Plot 8, Sector 75",
//                 style: TextStyle(fontSize: 12, color: Colors.white),
//               ),
//             ],
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                     const CryptoNotifications()),
//               );
//             },
//             child: Container(
//               height: 42,
//               width: 42,
//               padding: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(
//                 Icons.notification_important_rounded,
//                 color: AppColors.buttonColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
