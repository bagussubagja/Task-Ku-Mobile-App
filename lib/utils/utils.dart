import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static int idNotifGenerator(String value) {
    String generateValue = value.codeUnits.join().substring(0, 10);
    int id = int.parse(generateValue);
    return id;
  }

  static int numberOfPriority(String priority) {
    switch (priority) {
      case 'High Priority':
        return 4;
      case 'Medium Priority':
        return 3;
      case 'Low Priority':
        return 2;
      case 'Informational':
        return 1;
      default:
        return 0;
    }
  }

  static String formattedDateDisplayed(DateTime dateTime) {
    return DateFormat.yMMMMd().format(dateTime);
  }

  static void showSnackbar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(content),
      ),
    );
  }

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
