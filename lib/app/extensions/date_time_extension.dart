import 'package:intl/intl.dart';

/// Extension of DateTime class to get the month name of the given date.
///
/// Gets the month name of the given date in the format of MMMM.
/// For example, if the given date is 2022-01-01, it will return 'January'
extension DateTimeExtension on DateTime {
  /// Gets the month name of the given date in the format of MMMM.
  ///
  /// For example, if the given date is 2022-01-01, it will return 'January'
  String get toMonthName {
    return DateFormat.MMMM().format(this);
  }
}
