import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';

typedef Json = Map<String, dynamic>;

abstract class JsonUtils {
  static void printPrettyJson(dynamic json, {String? prefix}) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyprint = encoder.convert(json);
    if (prefix != null) {
      debugPrint('$prefix $prettyprint');
    } else {
      debugPrint(prettyprint);
    }
  }

  static void printJson(Json json, {String? prefix}) {
    if (prefix != null) {
      debugPrint('$prefix $json');
    } else {
      debugPrint(json.toString());
    }
  }

  static String setImageUrlFromJson(Map<String, dynamic> json) {
    String? path = json['image'];
    path ??= json['img'];
    return '$baseUrl/$path';
  }

  static String? setImageUrlNullableFromJson(Map<String, dynamic> json) {
    String? path = json['image'];
    path ??= json['img'];
    return path == null ? null : '$baseUrl/$path';
  }

  static bool setIsNotificationRead(Map<String, dynamic> json) {
    return json['read_at'] != null;
  }

  static Object? readValue(Map<dynamic, dynamic> json, String key) {
    return json;
  }

  static String stringFromJson(dynamic json) {
    return json.toString();
  }

  static MultipartFile fileToJson(String path) {
    return MultipartFile.fromFileSync(path, filename: basename(path));
  }
}
