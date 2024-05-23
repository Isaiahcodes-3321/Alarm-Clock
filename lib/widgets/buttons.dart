import 'package:flutter/material.dart';
import 'package:alarm_clock/themes/app_text.dart';

Widget materialButton() {
  return MaterialButton(onPressed: () {});
}

Widget outLineButton(String text,Color color, Color textColor, VoidCallback onPres,) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: color),
    ),
    onPressed: onPres,
    child: Text(
      text,
      style: AppTextStyle.medium(textColor),  
    ),
  );
}
