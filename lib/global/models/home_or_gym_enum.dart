import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum HouseOrGymEnum implements DropDownItemModel {
  house,
  gym;

  @override
  String get displayEntityName => displayName;

  @override
  String get displayName => "${"in".tr()} ${name.tr()}";

  @override
  int get id => index + 1;

  bool get isHouse => this == house;
  bool get isGym => this == gym;

  static int toJson(HouseOrGymEnum value) => value.index;

  static HouseOrGymEnum fromJson(int id) => values[id - 1];
}
