import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
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

  static MealTypeEnum fromJson(dynamic value) {
    debugPrint('🟡 MealTypeEnum.fromJson received: $value');
    final parsed = int.tryParse(value.toString());
    if (parsed != null && parsed >= 1 && parsed <= values.length) {
      final result = values[parsed - 1];
      debugPrint('✅ Parsed MealTypeEnum: $result');
      return result;
    }
    debugPrint('🔴 Invalid MealTypeEnum value: $value — fallback to breakfast');
    return MealTypeEnum.breakfast;
  }
}
