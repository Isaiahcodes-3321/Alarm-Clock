import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:alarm_clock/themes/app_text.dart';
import 'package:alarm_clock/themes/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:alarm_clock/view/timer/time_provider.dart';
import 'package:alarm_clock/view/nav_bar/nav_provider.dart';
import 'package:alarm_clock/view/timer/time_controller.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class CountDown extends StatelessWidget {
  const CountDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;
      var fontStyle = AppTextStyle.boldMedium(
        AppColors.blueColor,
      );
      var fontStyle1 = AppTextStyle.largeBold(
        AppColors.blueColor,
      );

      return Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 90.w,
              height: 45.h,
              child: CircularProgressIndicator(
                strokeWidth: 3.w,
                backgroundColor: Colors.red,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            ref.watch(isTimerSet) ?
            TimerCountdown(
              colonsTextStyle: fontStyle1,
              timeTextStyle: fontStyle1,
              descriptionTextStyle: fontStyle,
              format: CountDownTimerFormat.hoursMinutesSeconds,
              endTime: DateTime.now().add(
                Duration(
                  hours: ref.watch(intHour),
                  minutes: ref.watch(intMin),
                  seconds: ref.watch(intSec),
                ),
              ),
              onEnd: () async {
                await Alarm.set(alarmSettings: alarmSettings);
                EmptyTimer.emptyTimer();
                print("Timer finished");
              },
            ) : 
            Text('00 : 00 : 00',style: fontStyle1,),
            SizedBox(
              // color: Colors.red,
              width: 31.w,
              height: 30.h,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm_on_rounded,
                      color: AppColors.whiteColor,
                    ),
                    Text(
                      "${ref.watch(featureTime)}${ref.watch(featureTimePeriod)}",
                      style: AppTextStyle.boldMedium(
                        AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
