import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum VideoTypeEnum implements DropDownItemModel {
  link,
  file;

  @override
  String get displayName {
    switch (this) {
      case VideoTypeEnum.link:
        return "link_odd".tr();
      case VideoTypeEnum.file:
        return "file".tr();
    }
  }

  bool get isLink => this == link;
  bool get isFile => this == file;

  @override
  String get displayEntityName => displayName;

  @override
  int get id => index + 1;
}
