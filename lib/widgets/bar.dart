import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:alarm_clock/themes/app_text.dart';
import 'package:alarm_clock/themes/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget bar(String text, Widget widgetIcon1, widgetIcon2) {
  return Column(
    children: [
      SizedBox(
        height: 3.h,
      ),
      SizedBox(
        width: 100.w,
        height: 6.h,
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: Text(
                  text,
                  style: AppTextStyle.bold( 
                    AppColors.whiteColor,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                  width: 30.w,
                  // color: Colors.yellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [widgetIcon1, widgetIcon2],
                  )),
            ),
          ],
        ),
      ),
    ],
  );
}
