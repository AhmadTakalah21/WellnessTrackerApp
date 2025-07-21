import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum IngredientUnitEnum implements DropDownItemModel {
  gram,
  milliliter,
  piece;

  @override
  String get displayEntityName => displayName;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  static int toJson(IngredientUnitEnum unit) => unit.id;

  static IngredientUnitEnum fromJson(int id) => values[id - 1];
}
