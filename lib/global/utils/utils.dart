import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

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

  static Future<XFile?> urlToXFile(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final tempDir = await getTemporaryDirectory();
      final fileName = path.basename(imageUrl);
      final filePath = path.join(tempDir.path, fileName);

      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      return XFile(file.path);
    } else {
      return null;
    }
  }
}
