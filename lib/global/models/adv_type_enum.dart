import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum AdvTypeEnum implements DropDownItemModel {
  advertisement,
  offer;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  bool get isAdv => this == advertisement;

  static int toJson(AdvTypeEnum adv) => adv.id;

  static AdvTypeEnum fromJson(int id) => values[id - 1];

  @override
  String get displayEntityName => name.tr();
}
