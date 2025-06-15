import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum ActivityStatusEnum implements DropDownItemModel {
  active,
  inactive;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  bool get isActive {
    switch (this) {
      case ActivityStatusEnum.active:
        return true;
      case ActivityStatusEnum.inactive:
        return false;
    }
  }
}
