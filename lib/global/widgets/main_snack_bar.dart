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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? AppConstants.duration1500ms,
        backgroundColor: color ?? AppColors.green,
        content: Center(
          child: Text(
            message,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  static void showMessage(
    BuildContext context,
    String message, {
    Color? color,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? AppConstants.duration1500ms,
        backgroundColor: color ?? Colors.blueGrey.shade200,
        content: Center(
          child: Text(
            message,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  static void showErrorMessage(
    BuildContext context,
    String message, {
    Color? color,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? AppConstants.duration1500ms,
        backgroundColor: color ?? AppColors.red,
        content: Center(
          child: Text(
            message,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
