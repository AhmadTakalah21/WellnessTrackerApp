import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum YesNoEnum implements DropDownItemModel {
  yes,
  no;

  @override
  String get displayEntityName => displayName;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  bool get getBool => this == yes;

  static String toJson(YesNoEnum value) => value.getBool.toString();

  static YesNoEnum fromJson(int id) => values[id - 1];
}
