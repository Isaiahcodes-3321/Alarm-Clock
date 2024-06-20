import 'time_export.dart';
import 'package:flutter/material.dart';
import 'package:alarm_clock/widgets/notification.dart';




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
                backgroundColor: AppColors.whiteColor,
                valueColor: AlwaysStoppedAnimation(AppColors.blueColor),
              ),
            ),
            ref.watch(isTimerSet)
                ? TimerCountdown(
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
                      getVibrationValue();
                      getLoopingValue();
                      getVolumeValue();
                      EmptyTimer.emptyTimer();
                      showNotificationCountDown();
                      print("Timer finished");
                    },
                  )
                : Text(
                    '00 : 00 : 00',
                    style: fontStyle1,
                  ),
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


