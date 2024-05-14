import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget bar(Widget widgetIcon1, widgetIcon2) {
  return Column(
    children: [
      SizedBox(height: 3.h,),
      SizedBox(
        width: 100.w,
        height: 6.h,
        // color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
              width: 30.w,
              // color: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [widgetIcon1, widgetIcon2],
              )),
        ),
      ),
    ],
  );
}
