import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum DayEnum implements DropDownItemModel {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday;

  @override
  String get displayEntityName => displayName;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  static int toJson(DayEnum day) => day.id;

  static DayEnum fromJson(dynamic id) {
    final int? value = int.tryParse(id.toString());
    if (value != null && value >= 1 && value <= values.length) {
      return values[value - 1];
    }
    throw Exception("Invalid DayEnum value: $id");
  }
}
