import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get toMonthName {
    return DateFormat.MMMM().format(this);
  }
}
