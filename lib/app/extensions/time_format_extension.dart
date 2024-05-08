import 'package:flutter/material.dart';

extension TimeFormatExtension on TimeOfDay {
  String get formatTime {
    final time = DateTime.now();
    return '${time.hour}:${time.minute}:${time.second}';
  }

  /// convert `24h` to `12h` format with `AM/PM` suffix
  /// eg: 23:59:59 PM
  ///
  /// For example:
  /// ```dart
  /// final time = TimeOfDay(hour: 23, minute: 59, second: 59);
  /// print(time.formatTime12h); // 11:59:59 PM
  /// ```
  ///
  String get formatTime12h {
    final time = DateTime.now();
    return '${time.hour > 12 ? time.hour - 12 : time.hour == 0 ? 12 : time.hour}:${time.minute}:${time.second} ${time.hour > 12 ? 'PM' : 'AM'}';
  }
}
