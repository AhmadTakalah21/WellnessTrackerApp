import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class Utils {
  static Color? stringToColor(String color) {
    final hex = int.tryParse(color.substring(6, 16));
    if (hex == null) return null;
    return Color(hex);
  }

  static String convertDateFormat(String inputDate) {
    DateTime parsedDate = DateTime.parse(inputDate);
    String formattedDate =
        "${parsedDate.year}/${twoDigits(parsedDate.month)}/${twoDigits(parsedDate.day)}";
    return formattedDate;
  }

  static String twoDigits(int n) => n.toString().padLeft(2, '0');

  static String convertToIsoFormat(String inputDate) {
    DateFormat inputFormat = DateFormat('MM/dd/yyyy');
    DateTime parsedDate = inputFormat.parse(inputDate);

    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(parsedDate);
  }

  static String capitalizeFirst(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  static double calcSize(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return (size / 390) * screenWidth / 1.2;
    }
    return (size / 390) * screenWidth;
  }

  static String? validateEmptyValue(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'required'.tr();
    }
    return null;
  }

  static String? validateEmail(String? val) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (val == null || val.trim().isEmpty) {
      return 'email_empty'.tr();
    }
    if (!emailRegex.hasMatch(val)) {
      return 'email_invalid'.tr();
    }
    return null;
  }

  static String? validatePhone(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'required'.tr();
    } else if (val.length != 10) {
      return 'phone_number_10_digits'.tr();
    } else if (!val.startsWith('09')) {
      return 'phone_number_start_09'.tr();
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'password_empty'.tr();
    }
    if (val.length < 8) {
      return 'password_8_chars'.tr();
    }
    return null;
  }
}
