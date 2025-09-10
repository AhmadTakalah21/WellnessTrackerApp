import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

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

  static const String baseUrl = 'https://dev-mi.serv00.net';

  static bool isWebUrl(String s) =>
      s.startsWith('http://') || s.startsWith('https://');

  static bool isVideo(String s) {
    final l = s.toLowerCase();
    return l.endsWith('.mp4') ||
        l.endsWith('.mov') ||
        l.endsWith('.mkv') ||
        l.endsWith('.webm');
  }

  static String absoluteLink(String link) {
    if (link.isEmpty) return '';
    return isWebUrl(link) ? link : '$baseUrl/storage/$link';
  }

  static IconData iconForLink(String raw) {
    final url = absoluteLink(raw);
    if (url.isEmpty) return Icons.link_off;
    if (isVideo(url)) return Icons.play_circle_fill;
    return Icons.link;
  }

  static Future<void> openExternal(BuildContext context, String url) async {
    final ok =
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('cannot_open_link'.tr())),
      );
    }
  }

  static void onOpenMedia(BuildContext context, String raw,
      Widget Function(String url) videoPlayerBuilder) {
    final url = absoluteLink(raw);
    if (url.isEmpty) return;

    if (isVideo(url)) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => videoPlayerBuilder(url)),
      );
    } else {
      openExternal(context, url);
    }
  }

  static Future<Uint8List?> generateThumbnail(String url) async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final urlHash = md5.convert(utf8.encode(url)).toString();
      final thumbPath = p.join(cacheDir.path, '$urlHash.jpg');

      final thumbFile = File(thumbPath);
      if (await thumbFile.exists()) {
        return await thumbFile.readAsBytes();
      }

      final generatedPath = await VideoThumbnail.thumbnailFile(
        video: url,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 500,
        quality: 75,
        thumbnailPath: thumbPath,
      );

      if (generatedPath != null) {
        return await File(generatedPath).readAsBytes();
      }
      return null;
    } catch (e) {
      debugPrint("Thumbnail error: $e");
      return null;
    }
  }
}

enum InputTextType { email, phone, password, none }
