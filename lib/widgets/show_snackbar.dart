import 'package:flutter/material.dart';
import 'package:alarm_clock/themes/app_text.dart';
import 'package:alarm_clock/themes/app_colors.dart';

void showCustomSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(snackBar(text));
}

SnackBar snackBar(String text) {
  return SnackBar(
    content: Text(
      text,
      style: AppTextStyle.boldMedium(
        AppColors.whiteColor,
      ),
    ),
    backgroundColor: AppColors.blueColor,
    elevation: 10,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(5),
  );
}
