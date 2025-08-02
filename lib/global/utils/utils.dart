import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

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

  static String? validateInput(String? val, InputTextType type) {
    if (val == null || val.trim().isEmpty) {
      return 'required'.tr();
    }
    if (type == InputTextType.email) {
      final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );
      if (!emailRegex.hasMatch(val)) {
        return 'email_invalid'.tr();
      }
    } else if (type == InputTextType.phone) {
      if (val.length != 10) {
        return 'phone_number_10_digits'.tr();
      } else if (!val.startsWith('09')) {
        return 'phone_number_start_09'.tr();
      }
    } else if (type == InputTextType.password) {
      if (val.length < 8) {
        return 'password_8_chars'.tr();
      }
    }
    return null;
  }

  static MultipartFile fileToJson(String path) {
    return MultipartFile.fromFileSync(
      path,
      filename: basename(path),
    );
  }

  static MultipartFile? nullableFileToJson(String? path) {
    if (path == null) return null;
    return MultipartFile.fromFileSync(
      path,
      filename: basename(path),
    );
  }
}

enum InputTextType { email, phone, password, none }
