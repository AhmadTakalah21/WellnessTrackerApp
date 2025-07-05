import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum LevelEnum implements DropDownItemModel {
  level1,
  level2,
  level3;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;
}
