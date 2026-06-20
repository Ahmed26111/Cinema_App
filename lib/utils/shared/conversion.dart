import 'package:date_format/date_format.dart';

abstract class Conversion {
  static DateTime convertStringToDateTime(String date) {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(date);
    } on FormatException catch (e) {
      dateTime = DateTime.now();
    }
    return dateTime;
  }

  static String today() {
    return formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd]);
  }
}
