import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum DepartmentEnum implements DropDownItemModel {
  dietitian,
  coach,
  doctor,
  psychologist;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  bool get isDietitian => this == dietitian;
  bool get isCoach => this == coach;
  bool get isDoctor => this == doctor;
  bool get isPsychologist => this == psychologist;

  @override
  String get displayEntityName {
    switch (this) {
      case dietitian:
        return "nutrition".tr();
      case coach:
        return "sport".tr();
      case doctor:
        return "medicine".tr();
      case psychologist:
        return "psychology".tr();
    }
  }

  String get getTitle {
    switch (this) {
      case dietitian:
        return "nutrition_follow";
      case coach:
        return "sport_follow";
      case doctor:
        return "medical_follow";
      case psychologist:
        return "psicological_follow";
    }
  }

  IconData get getIcon {
    switch (this) {
      case dietitian:
        return Icons.restaurant_menu_rounded;
      case coach:
        return Icons.fitness_center_rounded;
      case doctor:
        return Icons.medication_rounded;
      case psychologist:
        return Icons.psychology;
    }
  }

  Color get getColor {
    switch (this) {
      case DepartmentEnum.dietitian:
        return Colors.green.shade400;
      case DepartmentEnum.coach:
        return Colors.blue.shade400;
      case DepartmentEnum.doctor:
        return Colors.red.shade400;
      case psychologist:
        return Colors.purple.shade400;
    }
  }

  static int toJson(DepartmentEnum role) => role.id;

  static DepartmentEnum fromJson(int id) => values[id - 1];

  static DepartmentEnum getDepartmentById(int id) => fromJson(id);

  static DepartmentEnum fromJson2(String role) =>
      values.firstWhere((value) => value.name == role, orElse: () => dietitian);

  static String toJson2(DepartmentEnum role) => role.name;
}
