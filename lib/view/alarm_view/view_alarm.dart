import 'package:flutter/material.dart';
import 'package:alarm_clock/widgets/bar.dart';
import 'package:alarm_clock/themes/app_text.dart';
import 'package:alarm_clock/themes/app_colors.dart';
import 'package:alarm_clock/widgets/bottom_sheet.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:alarm_clock/view/alarm_view/setting_alarm/setting_view.dart';

class ViewAlarm extends StatelessWidget {
  const ViewAlarm({super.key});

  @override
  Widget build(BuildContext context) {
    double iconSize = 24;
    return SizedBox(
        width: 100.w,
        height: 100.h,
        child: SafeArea(
          child: Column(
            children: [
              bar(
                'Alarm',
                GestureDetector(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const SettingAlarmView(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: AppColors.whiteColor,
                      size: iconSize,
                    )),
                PopupMenuButton(
                    iconSize: iconSize,
                    iconColor: AppColors.whiteColor,
                    color: AppColors.lightGreyColor,
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () {
                                Scaffold.of(context)
                                    .showBottomSheet((BuildContext context) {
                                  return const BottomSheetDisplay();
                                });
                              },
                              child: popMenuText('Alarm Setting')),
                          PopupMenuItem(
                              onTap: () {},
                              child:
                                  popMenuText('Set bedtime and wake-up time')),
                        ]),
              ),
            ],
          ),
        ));
  }
}

popMenuText(String text) => Text(
      text,
      style: AppTextStyle.mediumSmall(
        AppColors.whiteColor,
      ),
    );
