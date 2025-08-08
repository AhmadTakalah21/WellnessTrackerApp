import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum RatingEnum implements DropDownItemModel {
  bad,
  medium,
  good,
  verygood,
  perfect;

  @override
  int get id => index + 1;

  @override
  String get displayName {
    switch (this) {
      case RatingEnum.bad:
        return "bad".tr();
      case RatingEnum.medium:
        return "medium".tr();
      case RatingEnum.good:
        return "good".tr();
      case RatingEnum.verygood:
        return "very_good".tr();
      case RatingEnum.perfect:
        return "perfect".tr();
    }
  }

  @override
  String get displayEntityName => displayName;
}
