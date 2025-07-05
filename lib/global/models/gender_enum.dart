import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum GenderEnum implements DropDownItemModel {
  male,
  female;

  @override
  int get id => index + 1;

  @override
  String get displayName => name.tr();

  static GenderEnum? nullableFromJson(String? value) {
    if (GenderEnum.male.name == value) {
      return GenderEnum.male;
    } else if (GenderEnum.female.name == value) {
      return GenderEnum.female;
    } else if (value == null) {
      return null;
    } else {
      throw 'Gender type is not supported';
    }
  }

  static String? nullableToJson(GenderEnum? gender) => gender?.name;

  static GenderEnum fromJson(String value) {
    if (GenderEnum.male.name == value) {
      return GenderEnum.male;
    } else if (GenderEnum.female.name == value) {
      return GenderEnum.female;
    } else {
      throw 'Gender type is not supported';
    }
  }

  static String toJson(GenderEnum gender) => gender.name;

  bool get isMale => this == GenderEnum.male;

  bool get isFemale => this == GenderEnum.female;
}
