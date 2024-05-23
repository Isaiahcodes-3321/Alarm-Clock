import 'package:flutter/material.dart';
import 'package:alarm_clock/themes/app_text.dart';
import 'package:alarm_clock/themes/app_colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController textInput;
  final String hintText;
  final void Function(String) onChange;
  const TextInput({
    super.key,
    required this.textInput,
    required this.hintText,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textInput,
      keyboardType: TextInputType.number,
      onChanged: onChange,
      style: AppTextStyle.medium(AppColors.blueColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyle.medium(
          AppColors.blueColor,
        ),
        filled: false,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide.none),
      ),
    );
  }
}
