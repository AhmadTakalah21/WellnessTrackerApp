import 'package:easy_localization/easy_localization.dart';

extension DateX on DateTime {
  String get formatYYYYMMDD {
    return DateFormat('yyyy-MM-dd','en').format(this);
  }
}