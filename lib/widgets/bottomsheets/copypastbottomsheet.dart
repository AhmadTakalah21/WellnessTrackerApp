// import 'package:flutter/material.dart';
//
// import '../../Constants/colors.dart';
// import '../../views/TrackNumber/trackinglocation.dart';
// import '../custombtn.dart';
// import '../customtextfield.dart';
// import '../detailstext1.dart';
//
// class BottomSheetWidget {
//   static void addAddressBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: AppColors.bgColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15.0),
//           topRight: Radius.circular(15.0),
//         ),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           height: MediaQuery.of(context).size.height * 0.80,
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text1(
//                 text1: 'Save Address',
//                 size: 18,
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               const CustomTextField(
//                 icon: Icons.person_outline,
//                 label: 'Full Name',
//               ),
//               const CustomTextField(
//                 icon: Icons.phone,
//                 label: 'Phone Number',
//               ),
//               const CustomTextField(
//                 icon: Icons.email,
//                 label: 'Email Address',
//               ),
//               const CustomTextField(
//                 icon: Icons.location_on,
//                 label: 'Street Address',
//               ),
//               const CustomTextField(
//                 icon: Icons.location_city,
//                 label: 'City',
//               ),
//               const CustomTextField(
//                 icon: Icons.map,
//                 label: 'State',
//               ),
//               const CustomTextField(
//                 icon: Icons.markunread_mailbox,
//                 label: 'Zip Code',
//               ),
//               const CustomTextField(
//                 icon: Icons.location_on,
//                 label: 'Country',
//               ),
//               const CustomTextField(
//                 icon: Icons.apartment,
//                 label: 'Floor',
//               ),
//               const CustomTextField(
//                 icon: Icons.apartment,
//                 label: 'Landmark',
//               ),
//               const SizedBox(
//                 height: 11,
//               ),
//               CustomButton(text: 'Save Address', onTap: () {})
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   static void scanbarbottomsheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       builder: (context) {
//         return GestureDetector(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled:
//               true, // This allows it to occupy a larger portion of the screen
//               builder: (BuildContext context) {
//                 return const PackageTrackingBottomSheet();
//               },
//             );
//           },
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.8,
//             width: double.infinity,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                   child: Image.asset(
//                     'images/scabootomsheet.png',
//                     width: double.infinity,
//                     fit: BoxFit.fitWidth,
//                     height: 600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
