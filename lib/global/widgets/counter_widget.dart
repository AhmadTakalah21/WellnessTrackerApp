// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
// import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

// class CounterWidget extends StatelessWidget {
//   const CounterWidget({
//     super.key,
//     required this.controller,
//     required this.onIncreaseTap,
//     required this.onDecreaseTap,
//     required this.label,
//     required this.icon,
//   });
//   final TextEditingController controller;
//   final void Function() onIncreaseTap;
//   final void Function() onDecreaseTap;
//   final String label;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return MainTextField2(
//       controller: controller,
//       label: label,
//       icon: icon,
//       suffix: Column(
//         children: [
//           InkWell(
//             onTap: onIncreaseTap,
//             child: Icon(
//               Icons.arrow_drop_up,
//               color: context.cs.secondary,
//             ),
//           ),
//           InkWell(
//             onTap: onDecreaseTap,
//             child: Icon(
//               Icons.arrow_drop_down,
//               color: context.cs.secondary,
//             ),
//           ),
//         ],
//       ),
//       readOnly: true,
//       validator: (val) => val == null || val == '0' ? "required".tr() : null,
//     );
//   }
// }
