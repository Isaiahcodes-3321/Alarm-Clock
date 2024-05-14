import 'package:flutter/material.dart';
import 'package:alarm/themes/app_text.dart';
import 'package:alarm/themes/app_colors.dart';

Widget materialButton() {
  return MaterialButton(onPressed: () {});
}

Widget outLineButton(String text, VoidCallback onPres) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: AppColors.lightGreyColor),
    ),
    onPressed: onPres,
    child: Text(
      text,
      style: AppTextStyle.medium(AppColors.blueColor),
    ),
  );
}
