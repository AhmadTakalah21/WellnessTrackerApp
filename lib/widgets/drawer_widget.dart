// import 'package:flutter/material.dart';
// import 'package:glassmorphism_ui/glassmorphism_ui.dart';
//
// import '../views/TrackNumber/trackempty.dart';
// import '../views/boardingpass/boardingpass.dart';
// import '../views/bookingshipment/bookingshipment.dart';
// import '../views/chatflow/chat_screen.dart';
// import '../views/chekrates/chekrates.dart';
// import '../views/dropoff/dropoff.dart';
// import '../views/helpcenter/helpcenter.dart';
// import '../views/home/home.dart';
// import '../views/myparcels/myparcels.dart';
// import '../views/nearbydrop/nearbydrop.dart';
// import '../views/order/order_screen.dart';
// import '../views/parceltracking/parceltracking.dart';
// import '../views/paymentmethods/paymentmethods.dart';
// import '../views/pickup/pickupscreen.dart';
// import '../views/reviews/reviews.dart';
// import '../views/shipments/shipments.dart';
// import '../views/shipmentsdelivery/deliveryhistory.dart';
// import '../views/wallet/walletscreen.dart';
//
// class DrawerWidget extends StatefulWidget {
//   const DrawerWidget({super.key});
//
//   @override
//   State<DrawerWidget> createState() => _DrawerWidgetState();
// }
//
// class _DrawerWidgetState extends State<DrawerWidget> {
//   String selectedMenuItem = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return GlassContainer(
//       width: 270,
//       blur: 15,
//       borderRadius: BorderRadius.circular(30),
//       gradient: LinearGradient(
//         colors: [
//           Colors.blueGrey.shade900.withAlpha((0.8 * 255).toInt()),
//           Colors.blueGrey.shade700.withAlpha((0.8 * 255).toInt()),
//         ],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//       child: Column(
//         children: [
//           _buildProfileSection(),
//           const SizedBox(height: 10),
//           Expanded(
//             child: ListView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               children: [
//                 buildMenuItem("Home", Icons.home, () => navigateTo(HomeScreen())),
//                 buildMenuItem("Track Number", Icons.track_changes, () => navigateTo(TrackEmpty())),
//                 buildMenuItem("Boarding Pass", Icons.airplane_ticket, () => navigateTo(ShipmentBoardingPass())),
//                 buildMenuItem("Booking Shipment", Icons.local_shipping, () => navigateTo(BookShipmentScreen())),
//                 buildMenuItem("Chat", Icons.chat, () => navigateTo(ChatScreen())),
//                 buildMenuItem("Check Rates", Icons.sync_alt, () => navigateTo(ChekRates())),
//                 buildMenuItem("Drop-Off", Icons.location_on, () => navigateTo(DropoffScreen())),
//                 buildMenuItem("Help Center", Icons.help_outline, () => navigateTo(HelpCenterScreen())),
//                 buildMenuItem("Orders", Icons.list, () => navigateTo(OrderFormScreen())),
//                 buildMenuItem("History", Icons.history, () => navigateTo(DeliveryHistoryScreen())),
//                 buildMenuItem("My Parcels", Icons.local_mall, () => navigateTo(MyParcelsScreen())),
//                 buildMenuItem("Nearby Drop", Icons.map, () => navigateTo(NearByDrop())),
//                 buildMenuItem("Parcel Tracking", Icons.search, () => navigateTo(ParcelTrackingScreen())),
//                 buildMenuItem("Payment Methods", Icons.payment, () => navigateTo(PaymentMethodScreen())),
//                 buildMenuItem("Pickups", Icons.local_shipping, () => navigateTo(PickupScreen())),
//                 buildMenuItem("Reviews", Icons.rate_review, () => navigateTo(Reviews())),
//                 buildMenuItem("Shipments", Icons.local_offer, () => navigateTo(ShipmentsScreen())),
//                 buildMenuItem("Wallet", Icons.account_balance, () => navigateTo(WalletScreen())),
//                 const SizedBox(height: 10),
//                 const Divider(color: Colors.white30, thickness: 1),
//                 buildLogoutButton(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProfileSection() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.blue.shade700, Colors.blueAccent.shade200],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: const BorderRadius.only(
//           topRight: Radius.circular(30),
//         ),
//       ),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 30,
//             backgroundImage: AssetImage('images/c3.png'),
//           ),
//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Hello, James!',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: Text(
//                   'View Profile',
//                   style: TextStyle(
//                     color: Colors.white.withAlpha((0.8 * 255).toInt()),
//                     fontSize: 14,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildMenuItem(String title, IconData icon, VoidCallback onTap) {
//     bool isSelected = title == selectedMenuItem;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedMenuItem = title;
//         });
//         onTap();
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
//         decoration: BoxDecoration(
//           color: isSelected ?
//           Colors.blueAccent.withAlpha((0.2 * 255).toInt())
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 20, color: isSelected ? Colors.white : Colors.white70),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: isSelected ? Colors.white : Colors.white70,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             Icon(Icons.navigate_next, size: 20, color: isSelected ? Colors.white : Colors.white70),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildLogoutButton() {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.redAccent,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: const [
//             Icon(Icons.logout, color: Colors.white, size: 20),
//             SizedBox(width: 10),
//             Text("Logout", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void navigateTo(Widget page) {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => page));
//   }
// }