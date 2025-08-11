import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
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
    Flushbar(
      shouldIconPulse: true,
      onTap: (flushbar) => flushbar.dismiss(),
      margin: AppConstants.padding8,
      borderRadius: BorderRadius.circular(12),
      backgroundColor: backgroundColor,
      duration: duration ?? AppConstants.duration1500ms,
      flushbarPosition: FlushbarPosition.TOP,
      //icon: Icon(icon, color: AppColors.white),
      messageText: Center(
        child: Text(message, style: context.tt.titleMedium?.copyWith(
          color: context.cs.surface
        )),
      ),
    ).show(context);
  }
}
