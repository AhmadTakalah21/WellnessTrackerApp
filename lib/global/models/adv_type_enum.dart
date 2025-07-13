import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum AdvTypeEnum implements DropDownItemModel {
  advertisement,
  offer;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  bool get isAdv {
    switch (this) {
      case AdvTypeEnum.advertisement:
        return true;
      case AdvTypeEnum.offer:
        return false;
    }
  }

  static String toJson(AdvTypeEnum adv) {
    switch (adv) {
      case AdvTypeEnum.advertisement:
        return "ad";
      case AdvTypeEnum.offer:
        return "offer";
    }
  }

  static AdvTypeEnum fromJson(int id) {
    switch (id) {
      case 1:
        return advertisement;
      case 2:
        return offer;
      default:
        return advertisement;
    }
  }
  
  @override
  String get displayEntityName => name.tr();
}
