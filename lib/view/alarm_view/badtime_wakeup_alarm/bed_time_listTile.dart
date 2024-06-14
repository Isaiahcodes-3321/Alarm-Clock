import 'package:alarm_clock/view/alarm_view/badtime_wakeup_alarm/bedtime_export.dart';

class BedTimeListTile extends StatelessWidget {
  const BedTimeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;
      return ref.watch(isBedSet) ? showBedTimeAlarm() : const SizedBox();
    });
  }

  Widget showBedTimeAlarm() {
    return Container(
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColors.bottomSheetColor,
          borderRadius: BorderRadius.circular(15),
        ),
        width: 100.w,
        height: 16.h,
        child: Center(
          child: Row(
            children: [
              container(
                35.w,
                90.h,
                '${refProvider.watch(displayBedTimeHr)}:${refProvider.watch(displayBedTimeMin)}',
                refProvider.watch(displayBedTimePr),
                '${refProvider.watch(displayWakeTimeHr)}:${refProvider.watch(displayWakeTimeMin)}',
                refProvider.watch(displayWakeTimePr),
              ),
              SizedBox(
                  width: 53.w,
                  height: 90.h,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: text('MON TUE WED ThU FRI SAT SUN'),
                  ))
            ],
          ),
        ));
  }
}

Text text(String text, {TextStyle? style}) => Text(
      text,
      style: style ??
          AppTextStyle.mediumSmall(
            AppColors.whiteColor,
          ),
    );
Container container(double wd, hg, String sleepTime, sleepTimePeriod, wakeTime,
        wakeTimePeriod) =>
    Container(
      width: wd,
      height: hg,
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          bedTimeDisplay(sleepTime, sleepTimePeriod),
          bedTimeDisplay(wakeTime, wakeTimePeriod),
        ],
      ),
    );

Row bedTimeDisplay(String time, period) => Row(
      children: [
        text(
          time,
          style: AppTextStyle.largeBold(AppColors.whiteColor,
              fontSize: AppTextStyle.mediumBoldFont),
        ),
        SizedBox(
            height: 4.5.h,
            child:
                Align(alignment: Alignment.bottomRight, child: text(period))),
      ],
    );
