import 'package:intl/intl.dart' show DateFormat;

extension StringX on String {
  String get formatYYYYMMDD {
    final parsedDate = DateTime.parse(this);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }
}
