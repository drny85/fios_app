import 'package:intl/intl.dart';

class FormatDate {
  static String format(date) {
    return DateFormat.yMd('en_US').format(DateTime.tryParse(date));
  }
}
