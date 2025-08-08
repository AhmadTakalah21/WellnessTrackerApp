import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum ActivityStatusEnum implements DropDownItemModel {
  active,
  inactive;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  static int toJson(ActivityStatusEnum status) {
    switch (status) {
      case ActivityStatusEnum.active:
        return 1;
      case ActivityStatusEnum.inactive:
        return 0;
    }
  }

  static ActivityStatusEnum fromJson(int id) {
    switch (id) {
      case 1:
        return ActivityStatusEnum.active;
      case 0:
        return ActivityStatusEnum.inactive;
      default:
        return ActivityStatusEnum.inactive;
    }
  }

  bool get isActive => this == active;

  @override
  String get displayEntityName => name.tr();
}
