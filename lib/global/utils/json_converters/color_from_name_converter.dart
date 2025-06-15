import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorFromNameConverter implements JsonConverter<Color, String> {
  const ColorFromNameConverter();

  @override
  Color fromJson(String json) {
    for (var color in Colors.primaries) {
      if(color.toString() == json){
        return color;
      }
    }
    return Colors.transparent;
  }

  @override
  String toJson(Color color) => color.toString();
}
