// import 'package:flutter/material.dart';
// import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
// import 'package:wellnesstrackerapp/global/utils/constants.dart';

// abstract class MainSnackBar {
//   static void showSuccessMessage(
//     BuildContext context,
//     String message, {
//     Color? color,
//     Duration? duration,
//   }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: duration ?? AppConstants.duration1500ms,
//         backgroundColor: color ?? AppColors.green,
//         content: Center(
//           child: Text(
//             message,
//             style: TextStyle(
//               color: AppColors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   static void showMessage(
//     BuildContext context,
//     String message, {
//     Color? color,
//     Duration? duration,
//   }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: duration ?? AppConstants.duration1500ms,
//         backgroundColor: color ?? Colors.blueGrey.shade200,
//         content: Center(
//           child: Text(
//             message,
//             style: TextStyle(
//               color: AppColors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   static void showErrorMessage(
//     BuildContext context,
//     String message, {
//     Color? color,
//     Duration? duration,
//   }) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: duration ?? AppConstants.duration1500ms,
//         backgroundColor: color ?? AppColors.red,
//         content: Center(
//           child: Text(
//             message,
//             style: TextStyle(
//               color: AppColors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class MainSnackBar {
  static void showSuccessMessage(
      BuildContext context,
      String message, {
        Color? color,
        Duration? duration,
      }) {
    _showSnackBar(
      context,
      message,
      backgroundColor: color ?? AppColors.green,
      icon: Icons.check_circle,
      duration: duration,
    );
  }

  static void showMessage(
      BuildContext context,
      String message, {
        Color? color,
        Duration? duration,
      }) {
    _showSnackBar(
      context,
      message,
      backgroundColor: color ?? Colors.blueGrey.shade200,
      icon: Icons.info,
      duration: duration,
    );
  }

  static void showErrorMessage(
      BuildContext context,
      String message, {
        Color? color,
        Duration? duration,
      }) {
    _showSnackBar(
      context,
      message,
      backgroundColor: color ?? AppColors.red,
      icon: Icons.error,
      duration: duration,
    );
  }

  static void _showSnackBar(
      BuildContext context,
      String message, {
        required Color backgroundColor,
        required IconData icon,
        Duration? duration,
      }) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: duration ?? AppConstants.duration1500ms,
        backgroundColor: backgroundColor,
        content: Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: Row(
            children: [
              Icon(icon, color: AppColors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
