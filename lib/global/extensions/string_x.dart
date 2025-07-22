import 'package:easy_localization/easy_localization.dart';

extension StringX on String {
  String get formatYYYYMMDD {
    final parsedDate = DateTime.parse(this);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }
}

extension StringNullX on String? {
  bool get nullOrEmpty => this == null || this!.isEmpty;
  bool get notNullOrEmpty => this != null && this!.isNotEmpty;
}
