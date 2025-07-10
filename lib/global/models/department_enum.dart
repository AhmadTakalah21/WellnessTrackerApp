import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum DepartmentEnum implements DropDownItemModel {
  dietitian,
  coach,
  doctor;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

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

  static int toJson(DepartmentEnum role) => role.id;

  static DepartmentEnum getDepartmentById(int id) {
    switch (id) {
      case 1:
        return dietitian;
      case 2:
        return coach;
      case 3:
        return doctor;
      default:
        return dietitian;
    }
  }
}
