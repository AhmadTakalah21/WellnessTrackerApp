import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum PerPageEnum implements DropDownItemModel {
  ten,
  twenty,
  fifty,
  hundred;

  @override
  String get displayName {
    switch (this) {
      case PerPageEnum.ten:
        return "10";
      case PerPageEnum.twenty:
        return "20";
      case PerPageEnum.fifty:
        return "50";
      case PerPageEnum.hundred:
        return "100";
    }
  }

  @override
  int get id {
    switch (this) {
      case PerPageEnum.ten:
        return 10;
      case PerPageEnum.twenty:
        return 20;
      case PerPageEnum.fifty:
        return 50;
      case PerPageEnum.hundred:
        return 100;
    }
  }
}
