import 'package:flutter/material.dart';
import 'package:alarm_clock/themes/app_text.dart';
import 'package:alarm_clock/themes/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:alarm_clock/view/nav_bar/nav_provider.dart';
import 'package:alarm_clock/view/alarm_view/alarm_provider.dart';
import 'package:alarm_clock/view/alarm_view/bad_time_wakeup_alarm/bed_time_provider.dart';
import 'package:alarm_clock/view/alarm_view/display_alarm_list/list_alarm_controlls.dart';

class AlarmViewList extends StatelessWidget {
  const AlarmViewList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: refProvider.watch(isBedSet) ? 52.h : 70.h,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          int indexOfArray = index;
          return Dismissible(
            key: Key('key2'),
            direction: DismissDirection.endToStart,
            background: Container(
              color: AppColors.blueColor,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete,
                  size: 50,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            onDismissed: (direction){
              items = [];
            },
            child: Container(
              width: 100.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: AppColors.bottomSheetColor,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 40.w,
                    height: 7.h,
                    child: Text.rich(
                      TextSpan(
                        text: items[indexOfArray][0],
                        style: AppTextStyle.largeBold(AppColors.whiteColor,
                            fontSize: AppTextStyle.mediumBoldFont),
                        children: [
                          TextSpan(
                            text: items[indexOfArray][1],
                            style: AppTextStyle.mediumSmall(
                              AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                    height: 90.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        text(refProvider.watch(storageAllDaysSelectedFalse)
                            ? 'Every Day'
                            // refProvider.watch(storageAllDaysSelected)
                            : items[indexOfArray][2]),
                        text(items[indexOfArray][3]),
                        text(items[indexOfArray][4]),
                        text(items[indexOfArray][5]),
                        text(items[indexOfArray][6]),
                        text(items[indexOfArray][7]),
                        text(items[indexOfArray][8]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Text text(String text, {TextStyle? style}) => Text(
      text,
      style: style ??
          AppTextStyle.mediumSmall(
            AppColors.whiteColor,
          ),
    );
