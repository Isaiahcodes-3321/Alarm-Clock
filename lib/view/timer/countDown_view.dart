import 'package:flutter/material.dart';
import 'package:alarm/themes/app_text.dart';
import 'package:alarm/themes/app_colors.dart';
import 'package:alarm/view/timer/time_provider.dart';
import 'package:alarm/view/nav_bar/nav_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class CountDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;
      int hr = ref.watch(intHour);
      int min = ref.watch(intMin);
      int sec = ref.watch(intSec);
      print('my time $hr $min $sec');
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
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
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
              onEnd: () {
                print("Timer finished");
              },
            ),
          ],
        ),
      );
    });
  }
}

// class CountDown extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, _) {
//       var refProvider = ref;
//       int hour = refProvider.watch(intHour);
//       int min = refProvider.watch(intMin);
//       int sec = refProvider.watch(intSec);
//       var fontStyle = AppTextStyle.boldMedium(
//         AppColors.blueColor,
//       );
//       var fontStyle1 = AppTextStyle.largeBold(
//         AppColors.blueColor,
//       );

//       // Calculate total duration in seconds
//       int totalDuration = hour * 3600 + min * 60 + sec;

//       return Padding(
//         padding: EdgeInsets.only(top: 10),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             SizedBox(
//               width: 90,
//               height: 45,
//               child: CircularProgressIndicator(
//                 strokeWidth: 3,
//                 backgroundColor: const Color.fromARGB(255, 240, 21, 21),
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//                 value: 1.0,
//               ),
//             ),
//             CupertinoPageScaffold(
//               backgroundColor: AppColors.backgroundColor,
//               child: TimerCountdown(
//                 colonsTextStyle: fontStyle1,
//                 timeTextStyle: fontStyle1,
//                 descriptionTextStyle: fontStyle,
//                 format: CountDownTimerFormat.hoursMinutesSeconds,
//                 endTime: DateTime.now().add(
//                   Duration(
//                     hours: hour,
//                     minutes: min,
//                     seconds: sec,
//                   ),
//                 ),
//                 onEnd: () {
//                   print("Timer finished");
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }



