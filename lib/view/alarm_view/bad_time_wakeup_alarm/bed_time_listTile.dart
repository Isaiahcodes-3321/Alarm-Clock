import 'package:alarm_clock/view/global_controls/global_provider.dart';
import 'package:alarm_clock/view/alarm_view/bad_time_wakeup_alarm/bed_time_export.dart';

class BedTimeListTile extends StatelessWidget {
  const BedTimeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;
      return refProvider.watch(isBedSet)
          ? showBedTimeAlarm()
          : const SizedBox();
    });
  }

  Widget showBedTimeAlarm() {
    return SizedBox(
      width: 100.w,
      height: 20.h,
      child: Dismissible(
        key: Key('key1'),
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
        onDismissed: (direction) {
          refProvider.read(isNotificationClick.notifier).state = false;
          ClearBedTime.emptyStorage();
        },
        child: Container(
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
                    40.w,
                    90.h,
                    '${refProvider.watch(displayBedTimeHr)}:${refProvider.watch(displayBedTimeMin)}',
                    'Sleep',
                    refProvider.watch(displayBedTimePr),
                    '${refProvider.watch(displayWakeTimeHr)}:${refProvider.watch(displayWakeTimeMin)}',
                    'Wake',
                    refProvider.watch(displayWakeTimePr),
                  ),
                  SizedBox(
                      width: 50.w,
                      height: 90.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          refProvider.watch(isBedTimeM)
                              ? text(refProvider.watch(setMonText))
                              : text(''),
                          refProvider.watch(isBedTimeT)
                              ? text(refProvider.watch(setTueText))
                              : text(''),
                          refProvider.watch(isBedTimeW)
                              ? text(refProvider.watch(setWedText))
                              : text(''),
                          refProvider.watch(isBedTimeThr)
                              ? text(refProvider.watch(setThuText))
                              : text(''),
                          refProvider.watch(isBedTimeF)
                              ? text(refProvider.watch(setFriText))
                              : text(''),
                          refProvider.watch(isBedTimeSat)
                              ? text(refProvider.watch(setSatText))
                              : text(''),
                          refProvider.watch(isBedTimeSun)
                              ? text(refProvider.watch(setSunText))
                              : text('')
                        ],
                      ))
                ],
              ),
            )),
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
Container container(double wd, hg, String sleepTime, periodDayS,
        sleepTimePeriod, wakeTime, periodDayW, wakeTimePeriod) =>
    Container(
      width: wd,
      height: hg,
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          bedTimeDisplay(sleepTime, periodDayS, sleepTimePeriod),
          bedTimeDisplay(wakeTime, periodDayW, wakeTimePeriod),
        ],
      ),
    );

Row bedTimeDisplay(String time, period, period1) => Row(
      children: [
        text(
          time,
          style: AppTextStyle.largeBold(AppColors.whiteColor,
              fontSize: AppTextStyle.mediumBoldFont),
        ),
        SizedBox(width: 1.w),
        SizedBox(
          // color: const Color.fromRGBO(244, 67, 54, 1),
          height: 5.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [text(period), text(period1)],
          ),
        ),
      ],
    );
