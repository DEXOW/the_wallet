import 'package:flutter/material.dart';

class SnackBarNotify {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color? bgcolor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgcolor ?? Colors.white,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}