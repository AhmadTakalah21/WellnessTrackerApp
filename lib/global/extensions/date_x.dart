import 'package:easy_localization/easy_localization.dart';

extension StringX on DateTime {
  String get formatYYYYMMDD {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}