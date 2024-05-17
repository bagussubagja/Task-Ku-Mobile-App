import 'package:intl/intl.dart';

class Utils {
  static String formattedDateDisplayed (DateTime dateTime) {
    return DateFormat.yMMMMd().format(dateTime);
  }
}