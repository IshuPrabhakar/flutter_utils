part of extension;

extension DateEx on DateTime {
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
  String get time12 => DateFormat.jm(this).toString();

  /// Returns a string formatted date
  /// Example: 15:08 PM
  String get time24 => DateFormat.Hm(this).toString();

  /// Returns a string formatted date
  /// Example: 5:08 PM Monday, 15 September 2023
  String get defaultFormat {
    DateTime today = DateTime.now();
    Duration oneDay = const Duration(days: 1);
    Duration oneWeek = const Duration(days: 7);

    // Mapping month number to month name using a list for simplicity
    const List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    // Get month name from the list
    String month = months[this.month - 1];

    Duration difference = today.difference(this);
    var formattedTime = DateFormat.jm().format(this);

    // Check if the date is today
    if (difference.inDays == 0 && today.day == day) {
      return "$formattedTime, Today";
    }
    // Check if the date is yesterday
    else if (difference.compareTo(oneDay) < 1 && isBefore(today)) {
      return "$formattedTime, Yesterday";
    }
    // Check if the date is within the past week
    else if (difference.compareTo(oneWeek) < 1) {
      const List<String> weekdays = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"
      ];
      // Get weekday name
      String weekdayName = weekdays[weekday % 7];
      return "$formattedTime, $weekdayName";
    }
    // Check if the date is within the current year
    else if (year == today.year) {
      return '$day $month $year';
    }
    // If the date is in another year
    else {
      return '$day $month $year';
    }
  }
}
