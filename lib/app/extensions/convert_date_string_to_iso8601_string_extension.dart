extension ConvertDateStringToIso8601StringExtension on String {
  /// Converts a string in the format of 'yyyy-MM-dd' to an ISO8601
  /// string. The timezone is assumed to be UTC.
  ///
  /// Example: '2022-01-01' -> '2022-01-01T00:00:00.000Z'
  String convertDateStringToIso8601String() {
    final date = DateTime.parse(this);
    return '${date.toIso8601String()}Z';
  }
}
