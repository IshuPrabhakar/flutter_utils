part of extension;

extension DateHelper on DateTime {
  /// Returns true if it is today
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  /// Returns true if it is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  /// Returns a string formatted date
  ///  Example: 22/11/2023
  String get ddMMyyyy =>
      DateFormat("dd/MM/yyyy").format(this).toString().toUpperCase();

  /// Returns a string formatted date
  ///  Example: 5:08 PM
  String get time12Hrs => DateFormat.jm().toString();

  /// Returns a string formatted date
  ///  Example: 15:08 PM
  String get time24Hrs => DateFormat.Hm().toString();
}
