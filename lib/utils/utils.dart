import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
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
}
