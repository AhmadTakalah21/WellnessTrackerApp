import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum DepartmentEnum implements DropDownItemModel {
  dietitian,
  coach,
  doctor;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  @override
  String get displayEntityName {
    switch (this) {
      case DepartmentEnum.dietitian:
        return "nutrition".tr();
      case DepartmentEnum.coach:
        return "sport".tr();
      case DepartmentEnum.doctor:
        return "medicine".tr();
    }
  }

  String get getTitle {
    switch (this) {
      case DepartmentEnum.dietitian:
        return "nutrition_follow";
      case DepartmentEnum.coach:
        return "sport_follow";
      case DepartmentEnum.doctor:
        return "medical_follow";
    }
  }

  IconData get getIcon {
    switch (this) {
      case DepartmentEnum.dietitian:
        return Icons.restaurant_menu_rounded;
      case DepartmentEnum.coach:
        return Icons.fitness_center_rounded;
      case DepartmentEnum.doctor:
        return Icons.medication_rounded;
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
    }
  }

  static int toJson(DepartmentEnum role) => role.id;

  static DepartmentEnum fromJson(int id) => values[id - 1];

  static DepartmentEnum getDepartmentById(int id) => fromJson(id);
}
