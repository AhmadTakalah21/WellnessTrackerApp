import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum MealTypeEnum implements DropDownItemModel {
  breakfast,
  lunch,
  dinner,
  snack;

  @override
  String get displayEntityName => displayName;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  static int toJson(MealTypeEnum type) => type.id;

  static MealTypeEnum fromJson(int id) => values[id - 1];
}
