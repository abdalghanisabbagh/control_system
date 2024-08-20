extension ConvertDateStringToIso8601StringExtension on String {
  String convertDateStringToIso8601String() {
    final date = DateTime.parse(this).toUtc();
    return date.toIso8601String();
  }
}
