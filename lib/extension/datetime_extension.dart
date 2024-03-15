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

  String get defaultDateTimeFormat {
    DateTime today = DateTime.now();
    Duration oneDay = const Duration(days: 1);
    Duration twoDay = const Duration(days: 2);
    Duration oneWeek = const Duration(days: 7);
    late String month;

    switch (this.month) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
    }

    Duration difference = today.difference(this);
    var formattedTime = DateFormat.jm().format(this);
    if (difference.compareTo(oneDay) < 1) {
      return "$formattedTime, Today";
    } else if (difference.compareTo(twoDay) < 1) {
      return "$formattedTime, Yesterday";
    } else if (difference.compareTo(oneWeek) < 1) {
      switch (weekday) {
        case 1:
          return "$formattedTime, Monday";
        case 2:
          return "$formattedTime, Tuesday";
        case 3:
          return "$formattedTime, Wednesday";
        case 4:
          return "$formattedTime, Thursday";
        case 5:
          return "$formattedTime, Friday";
        case 6:
          return "$formattedTime, Saturday";
        default:
          return "$formattedTime, Sunday";
      }
    } else if (year == today.year) {
      return '$day $month $year';
    } else {
      return '$day $month $year';
    }
  }
}
