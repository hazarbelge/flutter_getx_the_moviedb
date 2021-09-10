import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension FormatPrinter on BuildContext {
  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours == 0 ? "$twoDigitMinutes:$twoDigitSeconds" : "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String printDateTime(DateTime dateTime) {
    String formatted;

    if (dateTime.year == DateTime.now().year && dateTime.month == DateTime.now().month && dateTime.day == DateTime.now().day)
      formatted = DateFormat("HH:mm", 'tr').format(dateTime);
    else if (dateTime.year == DateTime.now().year && dateTime.month == DateTime.now().month)
      formatted = DateFormat("dd MMMM HH:mm", 'tr').format(dateTime);
    else
      formatted = DateFormat("dd MMMM yyyy HH:mm", 'tr').format(dateTime);
    return formatted;
  }
}
