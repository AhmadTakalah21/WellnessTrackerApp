import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum HouseOrGymEnum implements DropDownItemModel {
  house,
  gym;

  @override
  String get displayEntityName => displayName;

  @override
  String get displayName => "${"in".tr()} ${name.tr()}";

  // ✅ خلي id يطابق السيرفر (0/1)
  @override
  int get id => index; // بدل index + 1

  bool get isHouse => this == house;
  bool get isGym => this == gym;

  // ✅ السيرفر يرسل 0/1
  static int toJson(HouseOrGymEnum value) => value.index;

  static HouseOrGymEnum fromJson(int id) {
    // حماية من أي قيمة غلط
    if (id == 0) return HouseOrGymEnum.house;
    if (id == 1) return HouseOrGymEnum.gym;
    return HouseOrGymEnum.house; // default
  }
}
