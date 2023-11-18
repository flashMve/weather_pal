import 'package:intl/intl.dart';

class DateParser {
  static String parse({String? locale}) {
    DateTime now = DateTime.now();

    // Get Date in this format 25 January, Wednesday
    final DateFormat formatter = DateFormat('d MMMM, EEEE', locale);

    String formatted = formatter.format(now);

    return formatted;
  }

  static String parseGivenDate(DateTime date, {String? locale}) {
    // Get Date in this format 25 January, Wednesday
    final DateFormat formatter = DateFormat('d MMMM, EEEE', locale);

    String formatted = formatter.format(date);

    return formatted;
  }
}
