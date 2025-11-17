import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';

enum SentOrReceivedEnum implements DropDownItemModel {
  sent,
  received;

  @override
  String get displayEntityName => displayName;

  @override
  String get displayName => name.tr();

  @override
  int get id => index + 1;

  bool get isSent => this == sent;
  bool get isReceived => this == received;
}
